/// Describes automated discovery.
pub const AutomatedDiscoveryInformation = struct {
    /// Time that automated discovery last ran.
    last_run_time: ?i64 = null,

    pub const json_field_names = .{
        .last_run_time = "LastRunTime",
    };
};
