// Disabling ESEL

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "ESEL", 0x00000000)
{
#endif
    // In DSDT, native ESEL is renamed ESEX
    // As a result, calls to it land here.
    Method(_SB.PCI0.XHC.ESEL)
    {
        // do nothing
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
