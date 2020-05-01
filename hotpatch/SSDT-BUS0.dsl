// Adding SMBUS device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "BUS0", 0)
{
#endif
    External (_SB_.PCI0.SBUS, DeviceObj)

    Scope (\_SB.PCI0.SBUS)
    {
        Device (BUS0)
        {
            Name (_CID, "smbus")
            Name (_ADR, Zero)
            Device (DVL0)
            {
                Name (_ADR, 0x57)
                Name (_CID, "diagsvault")
                Method (_DSM, 4)
                {
                    If (!Arg2) { Return (Buffer () { 0x03 } ) }
                    Return (Package () { "address", 0x57 })
                }
            }
        }

        Device (BUS1)
        {
            Name (_CID, "smbus")
            Name (_ADR, One)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF