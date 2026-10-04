const IntegrationPartition = @import("integration_partition.zig").IntegrationPartition;
const UnnestSpec = @import("unnest_spec.zig").UnnestSpec;

/// Properties used by the target leg to partition the data on the target.
pub const TargetTableConfig = struct {
    /// The ARN of the integration that owns this target table configuration.
    integration_arn: ?[]const u8 = null,

    /// Determines the file layout on the target.
    partition_spec: ?[]const IntegrationPartition = null,

    /// The optional name of a target table.
    target_table_name: ?[]const u8 = null,

    /// Specifies how nested objects are flattened to top-level elements. Valid
    /// values are: "TOPLEVEL", "FULL", or "NOUNNEST".
    unnest_spec: ?UnnestSpec = null,

    pub const json_field_names = .{
        .integration_arn = "IntegrationArn",
        .partition_spec = "PartitionSpec",
        .target_table_name = "TargetTableName",
        .unnest_spec = "UnnestSpec",
    };
};
