// Power Button Device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "PWRB", 0)
{
#endif
    Scope (\_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
