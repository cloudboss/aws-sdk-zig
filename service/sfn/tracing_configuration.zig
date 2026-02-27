/// Selects whether or not the state machine's X-Ray tracing is enabled. Default
/// is
/// `false`
pub const TracingConfiguration = struct {
    /// When set to `true`, X-Ray tracing is enabled.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
