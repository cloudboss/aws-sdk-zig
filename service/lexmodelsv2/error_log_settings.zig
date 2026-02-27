/// Settings parameters for the error logs, whether it is enabled or disabled.
pub const ErrorLogSettings = struct {
    /// Settings parameters for the error logs, when it is enabled.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
