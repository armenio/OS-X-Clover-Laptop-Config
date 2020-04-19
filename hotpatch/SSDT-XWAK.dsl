// Disabling XWAK

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "XWAK", 0)
{
#endif
    // In DSDT, native XWAK is renamed ZWAK
    // As a result, calls to it land here.
    External (_SB_.PCI0.XHC_, DeviceObj)

    Scope (\_SB.PCI0.XHC)
    {
        Method (XWAK)
        {
            // do nothing
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
