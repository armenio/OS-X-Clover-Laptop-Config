// Generic MATH Fix
// x87-compatible Floating Point Processing Unit
// Allow to fix MATH or dimply disable it

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "MATH", 0)
{
#endif
    External (_SB_.PCI0.LPCB.MATH, DeviceObj)
    
    External (_SB_.PCI0.LPCB.MATH._HID, IntObj)

    External (_SB_.PCI0.LPCB.MATH._STA, UnknownObj) // name or method
    External (_SB_.PCI0.LPCB.MATH._CRS, UnknownObj) // name or method

    Scope (\_SB.PCI0.LPCB.MATH)
    {
        If (!CondRefOf (\_SB.PCI0.LPCB.MATH._HID))
        {
            Name (_HID, EisaId ("PNP0C04"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.MATH._STA))
        {
            Name (_STA, 0x0F)
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.MATH._CRS))
        {
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                IO (Decode16,
                    0x00F0,             // Range Minimum
                    0x00F0,             // Range Maximum
                    0x01,               // Alignment
                    0x01,               // Length
                    )
                IRQNoFlags ()
                    {13}
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
