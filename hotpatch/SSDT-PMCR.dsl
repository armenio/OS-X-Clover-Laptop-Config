// PMC Device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "PMCR", 0)
{
#endif
    External (_SB_.PCI0, DeviceObj)

    Scope (\_SB.PCI0)
    {
        Device (PMCR)
        {
            Name (_HID, EisaId ("APP9876"))
            Name (_STA, 0x0B)
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,
                    0x00010000,
                    )
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
