DefinitionBlock ("", "SSDT", 2, "HACK", "ps2", 0)
{
    Name (_SB.PCI0.LPCB.PS2K.RMCF, Package ()
    {
        "Synaptics TouchPad", Package ()
        {
            "DynamicEWMode", ">y",
        },
    })
}
//EOF
