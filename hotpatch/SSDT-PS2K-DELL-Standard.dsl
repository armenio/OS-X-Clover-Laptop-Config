// Standard DELL 

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "PS2K", 0)
{
#endif
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (\_SB.PCI0.LPCB.PS2K)
    {
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (!Arg2) { Return (Buffer () { 0x03 } ) }
            Return (Package ()
            {
                "RM,oem-id", "DELL", 
                "RM,oem-table-id", "Standard"
            })
        }

        Name (RMCF, Package ()
        {
            "Synaptics TouchPad", Package ()
            {
                "QuietTimeAfterTyping", 1000000,
            }
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
