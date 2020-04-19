// From the-darkvoid repo
//
// SSDT-YTBT.dsl
//
// Dell XPS 15 9560
//
// This SSDT fixes an ACPI recursion that breaks Type-C hot plug.
//
// Credit to dpassmor:
// https://www.tonymacx86.com/threads/usb-c-hotplug-questions.211313/
//

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "YTBT", 0)
{
#endif
    Scope (\_GPE)
    {
        Method (YTBT, 2, NotSerialized)
        {
            Return (Zero)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
