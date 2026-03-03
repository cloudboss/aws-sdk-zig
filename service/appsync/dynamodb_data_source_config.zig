const DeltaSyncConfig = @import("delta_sync_config.zig").DeltaSyncConfig;

/// Describes an Amazon DynamoDB data source configuration.
pub const DynamodbDataSourceConfig = struct {
    /// The Amazon Web Services Region.
    aws_region: []const u8,

    /// The `DeltaSyncConfig` for a versioned data source.
    delta_sync_config: ?DeltaSyncConfig = null,

    /// The table name.
    table_name: []const u8,

    /// Set to TRUE to use Amazon Cognito credentials with this data source.
    use_caller_credentials: bool = false,

    /// Set to TRUE to use Conflict Detection and Resolution with this data source.
    versioned: bool = false,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .delta_sync_config = "deltaSyncConfig",
        .table_name = "tableName",
        .use_caller_credentials = "useCallerCredentials",
        .versioned = "versioned",
    };
};
