// Disabling ESEL

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "ESEL", 0)
{
#endif
    // In DSDT, native ESEL is renamed ESEX
    // As a result, calls to it land here.
    External (_SB_.PCI0.XHC, DeviceObj)

    Scope (\_SB.PCI0.XHC)
    {
        Method (ESEL)
        {
            // do nothing
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
