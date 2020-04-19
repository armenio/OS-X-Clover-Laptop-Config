// Sleep Button Device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "SLPB", 0)
{
#endif
    Scope (\_SB)
    {
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_STA, 0x0B)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
