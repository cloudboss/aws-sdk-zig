/// Overrides the on-demand throughput settings for this replica table. If you
/// don't
/// specify a value for this parameter, it uses the source table's on-demand
/// throughput
/// settings.
pub const OnDemandThroughputOverride = struct {
    /// Maximum number of read request units for the specified replica table.
    max_read_request_units: ?i64 = null,

    pub const json_field_names = .{
        .max_read_request_units = "MaxReadRequestUnits",
    };
};
