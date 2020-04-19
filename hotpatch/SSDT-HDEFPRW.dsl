// For solving instant wake by hooking GPRW

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "HDEFPRW", 0)
{
#endif
    // External (ZPRW, MethodObj)
    External (RMCF.DWOU, IntObj)

    // In DSDT, native HDEF._PRW is renamed ZPRW with Clover binpatch.
    // As a result, calls to HDEF._PRW land here.
    // The purpose of this implementation is to avoid "instant wake"
    // by returning 0 in the second position (sleep state supported)
    // of the return package.
    // HDEF._PRW is renamed to ZPRW so we can replace it here
    External (_SB_.PCI0.HDEF, DeviceObj)
    External (_SB.PCI0.HDEF.ZPRW, MethodObj)

    Scope (\_SB.PCI0.HDEF)
    {
        Method (_PRW, 0, NotSerialized)
        {
            Local0 = \_SB.PCI0.HDEF.ZPRW ()
            For (,,)
            {
                // when RMCF.DWOU is provided and is zero, patch disabled
                If (CondRefOf (\RMCF.DWOU)) { If (!\RMCF.DWOU) { Break }}
                // either RMCF.DWOU not provided, or is non-zero, patch is enabled
                Local0[1] = 0
                Break
            }
            Return (Local0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
