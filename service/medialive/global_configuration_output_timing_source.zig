/// Global Configuration Output Timing Source
pub const GlobalConfigurationOutputTimingSource = enum {
    input_clock,
    system_clock,

    pub const json_field_names = .{
        .input_clock = "INPUT_CLOCK",
        .system_clock = "SYSTEM_CLOCK",
    };
};
