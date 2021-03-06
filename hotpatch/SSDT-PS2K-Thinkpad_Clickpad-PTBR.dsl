// Example overrides for Thinkpad models with ClickPad

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "HACK", "PS2K", 0)
{
#endif
    // Change _SB.PCI0.LPCB.KBD if your PS2 keyboard is at a different ACPI path
    External (_SB_.PCI0.LPCB.KBD, DeviceObj)

    Scope (\_SB.PCI0.LPCB.KBD)
    {
        // Select specific configuration in VoodooPS2Trackpad.kext
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer () { 0x03 } ) }
            Return (Package ()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "Thinkpad_ClickPad",
            })
        }
        // Overrides (the example data here is default in the Info.plist)
        Name (RMCF, Package ()
        {
            "Keyboard", 
            Package ()
            {
                "Custom ADB Map", Package ()
                {
                    Package (){}, 
                    "e01d=5e", // RightCtrl=Slash
                },
                "RemapPrntScr", ">y",
                "Swap command and option", ">y",
            },
            "Synaptics TouchPad", Package ()
            {
                "BogusDeltaThreshX", 800,
                "BogusDeltaThreshY", 800,
                "Clicking", ">y",
                "DragLockTempMask", 0x40004,
                "DynamicEWMode", ">n",
                "FakeMiddleButton", ">n",
                "HWResetOnStart", ">y",
                //"ForcePassThrough", ">y",
                //"SkipPassThrough", ">y",
                "PalmNoAction When Typing", ">y",
                "QuietTimeAfterTyping", 1000000,
                "ScrollResolution", 800,
                "SmoothInput", ">y",
                "UnsmoothInput", ">y",
                "Thinkpad", ">y",
                "EdgeBottom", 0,
                "FingerZ", 30,
                "MaxTapTime", 100000000,
                "MouseMultiplierX", 2,
                "MouseMultiplierY", 2,
                "MouseScrollMultiplierX", 2,
                "MouseScrollMultiplierY", 2,
                //"TrackpointScrollYMultiplier", 1, //Change this value to 0xFFFF in order to inverse the vertical scroll direction of the Trackpoint when holding the middle mouse button.
                //"TrackpointScrollXMultiplier", 1, //Change this value to 0xFFFF in order to inverse the horizontal scroll direction of the Trackpoint when holding the middle mouse button.
            },
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
