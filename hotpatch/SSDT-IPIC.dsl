// Generic IPIC Fix
// 8259-compatible Programmable Interrupt Controller

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "IPIC", 0)
{
#endif
    External (_SB_.PCI0.LPCB.IPIC, DeviceObj)
    
    External (_SB_.PCI0.LPCB.IPIC._HID, IntObj)

    External (_SB_.PCI0.LPCB.IPIC._STA, UnknownObj) // name or method
    External (_SB_.PCI0.LPCB.IPIC._CRS, UnknownObj) // name or method

    Scope (\_SB.PCI0.LPCB.IPIC)
    {
        If (!CondRefOf (\_SB.PCI0.LPCB.IPIC._HID))
        {
            Name (_HID, EisaId ("PNP0000"))
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.IPIC._STA))
        {
            Name (_STA, 0x0F)
        }

        If (!CondRefOf (\_SB.PCI0.LPCB.IPIC._CRS))
        {
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0020,
                    0x0020,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x0024,
                    0x0024,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x0028,
                    0x0028,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x002C,
                    0x002C,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x0030,
                    0x0030,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x0034,
                    0x0034,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x0038,
                    0x0038,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x003C,
                    0x003C,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00A0,
                    0x00A0,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00A4,
                    0x00A4,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00A8,
                    0x00A8,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00AC,
                    0x00AC,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00B0,
                    0x00B0,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00B4,
                    0x00B4,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00B8,
                    0x00B8,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x00BC,
                    0x00BC,
                    0x01,
                    0x02,
                    )
                IO (Decode16,
                    0x04D0,
                    0x04D0,
                    0x01,
                    0x02,
                    )
                IRQNoFlags ()
                    {2}
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
