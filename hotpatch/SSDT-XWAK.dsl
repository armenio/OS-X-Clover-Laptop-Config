// Disabling XWAK

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "XWAK", 0x00000000)
{
#endif
    // In DSDT, native XWAK is renamed ZWAK
    // As a result, calls to it land here.
    Method(_SB.PCI0.XHC.XWAK)
    {
        // do nothing
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
