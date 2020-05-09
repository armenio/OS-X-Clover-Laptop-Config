// SSDT-BATC.dsl
//
// An SSDT to combine two batteries into one
// initial work/testing by ag6952563 (with assistance by RehabMan)
// finalize into generic SSDT by RehabMan
// some code cleanup/optimization/and bug fixing by RehabMan
//
// OS X support for multiple batteries is a bit buggy.
// This SSDT can be used to combine two batteries into one,
// avoiding the bugs.
//
// It may need modification depending on the ACPI path of your
// existing battery objects.
//

// IMPORTANT:
//
// To use this SSDT, you must also patch any Notify for either BAT0 or BAT1
// objects.
//
// The Notify is used to tell the system when a battery is removed or added.
//
// Any code:
//   Notify (...BAT0, ...)
//         -or
//   Notify (...BAT1, ...)
//
// Must be changed to:
//   Notify (...BATC, ...)
//
// Also, you must use ACPIBatteryManager.kext v1.70.0 or greater.
//
// If the Notify code is not patched, or the latest kext is not used,
// detection of battery removal/adding will not work correctly.
//
// You can Clover hotpatch (config.plist/ACPI/DSDT/Patches) your battery code.
//
// For example, Notify (BAT0, 0x80) is
//   86 42 41 54 30 0A 80
// To change it to Notify (BATC, 0x80):
//   86 42 41 54 43 0A 80
//
// Sometimes, you'll find there is a fully qualified path.
// Such as, Notify (\_SB.PCI0.LPCB.EC.BAT1, 0x01)
//   86 5C 2F 05 5F 53 42 5F 50 43 49 30 4C 50 43 42 45 43 5F 5F 42 41 54 31 0A 01
// Changing to BATC:
//   86 5C 2F 05 5F 53 42 5F 50 43 49 30 4C 50 43 42 45 43 5F 5F 42 41 54 43 0A 01
//

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "BATC", 0)
{
#endif
    External (_SB_.PCI0.LPCB.EC, DeviceObj)
    External (_SB_.PCI0.LPCB.EC.BAT0, DeviceObj)
    External (_SB_.PCI0.LPCB.EC.BAT0._BIF, MethodObj)
    External (_SB_.PCI0.LPCB.EC.BAT0._BST, MethodObj)
    External (_SB_.PCI0.LPCB.EC.BAT0._HID, IntObj)
    External (_SB_.PCI0.LPCB.EC.BAT0._STA, MethodObj)
    External (_SB_.PCI0.LPCB.EC.BAT1, DeviceObj)
    External (_SB_.PCI0.LPCB.EC.BAT1._BIF, MethodObj)
    External (_SB_.PCI0.LPCB.EC.BAT1._BST, MethodObj)
    External (_SB_.PCI0.LPCB.EC.BAT1._HID, IntObj)
    External (_SB_.PCI0.LPCB.EC.BAT1._STA, MethodObj)

    Scope (\_SB.PCI0.LPCB.EC)
    {
        Device (BATC)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)

            Method (_INI)
            {
                // disable original battery objects by setting invalid _HID
                ^^BAT0._HID = 0
                ^^BAT1._HID = 0
            }

            Method (_STA)
            {
                // call original _STA for BAT0 and BAT1
                // result is bitwise OR between them
                Return (^^BAT0._STA () | ^^BAT1._STA ())
            }

            Method (_BST)
            {
                // Local0 BAT0._BST
                // Local1 BAT1._BST
                // Local2 BAT0._STA
                // Local3 BAT1._STA
                // Local4/Local5 scratch

                // gather battery data from BAT0
                Local0 = ^^BAT0._BST ()
                Local2 = ^^BAT0._STA ()
                If (0x1f == Local2)
                {
                    // check for invalid remaining capacity
                    Local4 = DerefOf (Local0[2])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                }
                // gather battery data from BAT1
                Local1 = ^^BAT1._BST ()
                Local3 = ^^BAT1._STA ()
                If (0x1f == Local3)
                {
                    // check for invalid remaining capacity
                    Local4 = DerefOf (Local1[2])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                }
                // find primary and secondary battery
                If (0x1f != Local2 && 0x1f == Local3)
                {
                    // make primary use BAT1 data
                    Local0 = Local1 // BAT1._BST result
                    Local2 = Local3 // BAT1._STA result
                    Local3 = 0  // no secondary battery
                }
                // combine batteries into Local0 result if possible
                If (0x1f == Local2 && 0x1f == Local3)
                {
                    // _BST 0 - Battery State - if one battery is charging, then charging, else discharging
                    Local4 = DerefOf (Local0[0])
                    Local5 = DerefOf (Local1[0])
                    If (Local4 == 2 || Local5 == 2)
                    {
                        // 2 = charging
                        Local0[0] = 2
                    }
                    ElseIf (Local4 == 1 || Local5 == 1)
                    {
                        // 1 = discharging
                        Local0[0] = 1
                    }
                    ElseIf (Local4 == 5 || Local5 == 5)
                    {
                        // critical and discharging
                        Local0[0] = 5
                    }
                    ElseIf (Local4 == 4 || Local5 == 4)
                    {
                        // critical
                        Local0[0] = 4
                    }
                    // if none of the above, just leave as BAT0 is

                    // _BST 1 - Battery Present Rate - Add BAT0 and BAT1 values
                    Local0[1] = DerefOf (Local0[1]) + DerefOf (Local1[1])
                    // _BST 2 - Battery Remaining Capacity - Add BAT0 and BAT1 values
                    Local0[2] = DerefOf (Local0[2]) + DerefOf (Local1[2])
                    // _BST 3 - Battery Present Voltage - Average BAT0 and BAT1 values
                    Local0[3] = (DerefOf (Local0[3]) + DerefOf (Local1[3])) / 2
                }
                Return (Local0)
            } // _BST

            Method (_BIF)
            {
                // Local0 BAT0._BIF
                // Local1 BAT1._BIF
                // Local2 BAT0._STA
                // Local3 BAT1._STA
                // Local4/Local5 scratch

                // gather and validate data from BAT0
                Local0 = ^^BAT0._BIF ()
                Local2 = ^^BAT0._STA ()
                If (0x1f == Local2)
                {
                    // check for invalid design capacity
                    Local4 = DerefOf (Local0[1])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                    // check for invalid max capacity
                    Local4 = DerefOf (Local0[2])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                    // check for invalid design voltage
                    Local4 = DerefOf (Local0[4])
                    If (!Local4 || Ones == Local4) { Local2 = 0; }
                }
                // gather and validate data from BAT1
                Local1 = ^^BAT1._BIF ()
                Local3 = ^^BAT1._STA ()
                If (0x1f == Local3)
                {
                    // check for invalid design capacity
                    Local4 = DerefOf (Local1[1])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                    // check for invalid max capacity
                    Local4 = DerefOf (Local1[2])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                    // check for invalid design voltage
                    Local4 = DerefOf (Local1[4])
                    If (!Local4 || Ones == Local4) { Local3 = 0; }
                }
                // find primary and secondary battery
                If (0x1f != Local2 && 0x1f == Local3)
                {
                    // make primary use BAT1 data
                    Local0 = Local1 // BAT1._BIF result
                    Local2 = Local3 // BAT1._STA result
                    Local3 = 0  // no secondary battery
                }
                // combine batteries into Local0 result if possible
                If (0x1f == Local2 && 0x1f == Local3)
                {
                    // _BIF 0 - Power Unit - 0 = mWh | 1 = mAh
                    // _BIF 1 - Design Capacity - add BAT0 and BAT1 values
                    Local0[1] = DerefOf (Local0[1]) + DerefOf (Local1[1])
                    // _BIF 2 - Last Full Charge Capacity - add BAT0 and BAT1 values
                    Local0[2] = DerefOf (Local0[2]) + DerefOf (Local1[2])
                    // _BIF 3 - Battery Technology - leave BAT0 value
                    // _BIF 4 - Design Voltage - average BAT0 and BAT1 values
                    Local0[4] = (DerefOf (Local0[4]) + DerefOf (Local1[4])) / 2
                    // _BIF 5 - Design Capacity Warning - add BAT0 and BAT1 values
                    Local0[5] = DerefOf (Local0[5]) + DerefOf (Local1[5])
                    // _BIF 6 - Design Capacity of Low - add BAT0 and BAT1 values
                    Local0[6] = DerefOf (Local0[6]) + DerefOf (Local1[6])
                    // _BIF 7 - Capacity Granularity 1 - Leave BAT0 value for now
                    // _BIF 8 - Capacity Granularity 2 - Leave BAT0 value for now
                    // _BIF 9 - Model Number - Leave BAT0 value for now
                    // _BIF A - Serial Number - Leave BAT0 value for now
                    // _BIF B - Battery Type - Leave BAT0 value for now
                    // _BIF C - OEM Information - Leave BAT0 value for now
                }
                Return (Local0)
            } // _BIF
        } // BATC
    } // Scope (...)
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
