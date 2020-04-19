// Generic TIMR Fix
// PC-class System Timer

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "TIMR", 0)
{
#endif
    External (_SB_.PCI0.LPCB.TIMR, DeviceObj)
    
    External (_SB_.PCI0.LPCB.TIMR._HID, IntObj)

    External (_SB_.PCI0.LPCB.TIMR._STA, UnknownObj) // name or method
    External (_SB_.PCI0.LPCB.TIMR._CRS, UnknownObj) // name or method

    Scope (\_SB.PCI0.LPCB.TIMR)
    {
        If (!CondRefOf (\_SB.PCI0.LPCB.TIMR._HID))
        {
            Name (_HID, EisaId ("PNP0100"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.TIMR._STA))
        {
            Name (_STA, 0x0F)
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.TIMR._CRS))
        {
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0040,
                    0x0040,
                    0x01,
                    0x04,
                    )
                IO (Decode16,
                    0x0050,
                    0x0050,
                    0x10,
                    0x04,
                    )
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
