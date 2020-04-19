// From RehabMan repo
//
// USB Power Propertes for Sierra
//
// Note: Only used when using an SMBIOS without power properties
//  in IOUSBHostFamily Info.plist
//

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "_USBX", 0)
{
#endif
    Scope (\_SB)
    {
        Device(USBX)
        {
            Name(_ADR, 0)
            Method (_DSM, 4)
            {
                If (!Arg2) { Return (Buffer() { 0x03 } ) }
                Return (Package()
                {
                    // from MacBookPro13+
                    "kUSBSleepPortCurrentLimit", 0x0BB8, 
                    "kUSBWakePortCurrentLimit", 0x0BB8,
                })
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
