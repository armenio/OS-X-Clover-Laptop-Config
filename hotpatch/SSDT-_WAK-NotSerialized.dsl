// Overriding _WAK (NotSerialized)
// Based on SSDT-PTSWAK.dsl

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "_WAK", 0)
{
#endif
    External (ZWAK, MethodObj)

    External (_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    External (_SB.PCI0.PEGP.DGFX._OFF, MethodObj)

    External (RMCF.DPTS, IntObj)
    External (RMCF.SSTF, IntObj)
    External (_SI._SST, MethodObj)

    // In DSDT, native _PTS and _WAK are renamed ZWAK
    // As a result, calls to these methods land here.
    Method (_WAK, 1, NotSerialized)
    {
        // Take care of bug regarding Arg0 in certain versions of OS X...
        // (starting at 10.8.5, confirmed fixed 10.10.2)
        If (Arg0 < 1 || Arg0 > 5) { Arg0 = 3 }

        // call into original _WAK method
        Local0 = ZWAK (Arg0)

        If (CondRefOf (\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // disable discrete graphics
                If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF)) { \_SB.PCI0.PEG0.PEGP._OFF () }
                If (CondRefOf (\_SB.PCI0.PEGP.DGFX._OFF)) { \_SB.PCI0.PEGP.DGFX._OFF () }
            }
        }

        If (CondRefOf (\RMCF.SSTF))
        {
            If (\RMCF.SSTF)
            {
                // call _SI._SST to indicate system "working"
                // for more info, read ACPI specification
                If (3 == Arg0 && CondRefOf (\_SI._SST)) { \_SI._SST (1) }
            }
        }

        // return value from original _WAK
        Return (Local0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF