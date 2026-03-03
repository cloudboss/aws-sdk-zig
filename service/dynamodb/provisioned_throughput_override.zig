/// Replica-specific provisioned throughput settings. If not specified, uses the
/// source
/// table's provisioned throughput settings.
pub const ProvisionedThroughputOverride = struct {
    /// Replica-specific read capacity units. If not specified, uses the source
    /// table's read
    /// capacity settings.
    read_capacity_units: ?i64 = null,

    pub const json_field_names = .{
        .read_capacity_units = "ReadCapacityUnits",
    };
};
