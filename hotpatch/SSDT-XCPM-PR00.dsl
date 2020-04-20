// Inject plugin-type=1 on _PR.PR00

// This is experimental to see how only injecting plugin-type with native CPU PM SSDTs
// works on various platforms.
//
// Results: OK on Haswell+, not so good on Ivy
// Notes:
//   iMac17,1 and MacBook9,1 do not have APSS/ACST/APLF/etc
//   others like MacBookPro12,x, MacBook11,x do have it, but it is possible they are not used
//   likely any HWP enabled SMBIOS does not have APSS/ACST/APLF/etc and does not need it
//   could be that any XCPM enabled SMBIOS needs only this plugin-type injection
//
// Newer KabyLake/KabyLake-R/CoffeeLake boards use _PR.PR00, or _PR.P000 as first CPU path.
// Adjust this code according to what you find for Processor objects in your own DSDT.

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "XCPM", 0)
{
#endif
    External (_PR_.PR00, ProcessorObj)

    Scope (\_PR.PR00)
    {
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer () { 0x03 } ) }
            Return (Package ()
            {
                "plugin-type", 1
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
