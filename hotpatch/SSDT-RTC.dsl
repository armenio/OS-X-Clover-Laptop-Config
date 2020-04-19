// Generic RTC Fix
// Time and Alarm Device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "RTC", 0)
{
#endif
    External (_SB_.PCI0.LPCB.RTC, DeviceObj)
    
    External (_SB_.PCI0.LPCB.RTC._HID, IntObj)

    External (_SB_.PCI0.LPCB.RTC._STA, UnknownObj) // name or method
    External (_SB_.PCI0.LPCB.RTC._CRS, UnknownObj) // name or method

    Scope (\_SB.PCI0.LPCB.RTC)
    {
        If (!CondRefOf (\_SB.PCI0.LPCB.RTC._HID))
        {
            Name (_HID, EisaId ("PNP0B00"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.RTC._STA))
        {
            Name (_STA, 0x0F)
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.RTC._CRS))
        {
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0070,
                    0x0070,
                    0x01,
                    0x08,
                    )
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
