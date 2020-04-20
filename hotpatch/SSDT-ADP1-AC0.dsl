// ADP1 Power Resources for Wake
// Base on RehabMan system_ADP1.txt

// RehabMan Note: if AppleACPIACAdapter is already loading (look at your ioreg), then
//  this patch is not necessary for you.

// RehabMan Note: Old patch used to rename AC or ACAD to ADP1 to be more "Apple" like
//  Turns out, this is not needed.

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "ADP1", 0)
{
#endif
    External (_SB_.PCI0.LPCB.EC.AC0, DeviceObj)

    Scope (\_SB.PCI0.LPCB.EC.AC0)
    {
        Name (_PRW, Package() { 0x18, 0x03 })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
