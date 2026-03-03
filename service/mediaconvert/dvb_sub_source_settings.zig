/// DVB Sub Source Settings
pub const DvbSubSourceSettings = struct {
    /// When using DVB-Sub with Burn-in, use this PID for the source content. Unused
    /// for DVB-Sub passthrough. All DVB-Sub content is passed through, regardless
    /// of selectors.
    pid: ?i32 = null,

    pub const json_field_names = .{
        .pid = "Pid",
    };
};
