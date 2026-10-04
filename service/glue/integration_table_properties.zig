const SourceTableConfig = @import("source_table_config.zig").SourceTableConfig;
const TargetTableConfig = @import("target_table_config.zig").TargetTableConfig;

/// The properties of a single integration table, including the resource ARN,
/// the table name, and the source or target table configuration.
pub const IntegrationTableProperties = struct {
    /// The connection ARN of the source, or the database ARN of the target.
    resource_arn: []const u8,

    /// A structure for the source table configuration.
    source_table_config: ?SourceTableConfig = null,

    /// The name of the source table to be replicated.
    table_name: []const u8,

    /// A structure for the target table configuration.
    target_table_config: ?TargetTableConfig = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .source_table_config = "SourceTableConfig",
        .table_name = "TableName",
        .target_table_config = "TargetTableConfig",
    };
};
