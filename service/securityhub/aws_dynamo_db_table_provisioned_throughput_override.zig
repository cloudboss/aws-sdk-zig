/// Replica-specific configuration for the provisioned throughput.
pub const AwsDynamoDbTableProvisionedThroughputOverride = struct {
    /// The read capacity units for the replica.
    read_capacity_units: ?i32,

    pub const json_field_names = .{
        .read_capacity_units = "ReadCapacityUnits",
    };
};
