// Disabling XSEL (Serialized)
// Based on SSDT-XSEL.dsl

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "XSEL", 0)
{
#endif
    // In DSDT, native XSEL is renamed ZSEL
    // As a result, calls to it land here.
    External (_SB_.PCI0.XHC, DeviceObj)

    Scope (\_SB.PCI0.XHC)
    {
        Method (XSEL, 0, Serialized)
        {
            // do nothing
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
