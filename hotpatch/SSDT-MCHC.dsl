// adding Device MCHC

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "MCHC", 0)
{
#endif
    External (_SB_.PCI0, DeviceObj)

    Scope (\_SB.PCI0)
    {
        Device (MCHC)
        {
            Name (_ADR, Zero)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
