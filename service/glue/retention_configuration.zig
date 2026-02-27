const IcebergRetentionConfiguration = @import("iceberg_retention_configuration.zig").IcebergRetentionConfiguration;

/// The configuration for a snapshot retention optimizer.
pub const RetentionConfiguration = struct {
    /// The configuration for an Iceberg snapshot retention optimizer.
    iceberg_configuration: ?IcebergRetentionConfiguration,

    pub const json_field_names = .{
        .iceberg_configuration = "icebergConfiguration",
    };
};
