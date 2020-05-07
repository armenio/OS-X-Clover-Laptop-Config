// Enabling deep idle PM
// Based on https://github.com/osy86/HaC-Mini/blob/master/ACPI/SSDT-PmEnable.asl
// https://pikeralpha.wordpress.com/2017/01/12/debugging-sleep-issues/

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "DEEPIDLE", 0)
{
#endif
    Scope (\)
    {
       Name (SLTP, Zero)
     
       Method (_TTS, 1, NotSerialized)
       {
           Store (Arg0, SLTP)
       }
    }

    Scope (\_SB)
    {
        // This enables deep idle
        Method (LPS0, 0, NotSerialized)
        {
            Return (One)
        }
    }
     
    Scope (\_GPE)
    {
        // This tells xnu to evaluate _GPE.Lxx methods on resume
        Method (LXEN, 0, NotSerialized)
        {
            Return (One)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
