// Fake ambient light sensor device

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "ALS0", 0)
{
#endif
    External (_SB_.PCI0.LPCB, DeviceObj)

    Scope (\_SB.PCI0.LPCB)
    {
        Device (ALS0)
        {
            Name (_HID, "ACPI0008")
            Name (_CID, "smc-als")
            Name (_STA, 0x0F)
            Name (_ALI, 0x012C)
            Name (_ALR, Package ()
            {
                //Package () { 70, 0 },
                //Package () { 73, 10 },
                //Package () { 85, 80 },
                Package () { 100, 300 },
                //Package () { 150, 1000 },
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
