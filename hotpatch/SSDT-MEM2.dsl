// System Board

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "MEM2", 0)
{
#endif
    External (_SB_.PCI0.IGPU, DeviceObj)

    Scope (\_SB.PCI0.IGPU)
    {
        Device (^^MEM2)
        {
            Name (_HID, EisaId ("PNP0C01"))
            Name (_UID, 0x02)
            Name (CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x20000000,
                    0x00200000,
                    )
                Memory32Fixed (ReadWrite,
                    0x40000000,
                    0x00200000,
                    )
            })
            Method (_CRS, 0, NotSerialized)
            {
                Return (CRS)
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
