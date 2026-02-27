/// The connector-specific profile properties required when using Snowflake.
pub const SnowflakeConnectorProfileProperties = struct {
    /// The name of the account.
    account_name: ?[]const u8,

    /// The name of the Amazon S3 bucket associated with Snowflake.
    bucket_name: []const u8,

    /// The bucket path that refers to the Amazon S3 bucket associated with
    /// Snowflake.
    bucket_prefix: ?[]const u8,

    /// The Snowflake Private Link service name to be used for private data
    /// transfers.
    private_link_service_name: ?[]const u8,

    /// The Amazon Web Services Region of the Snowflake account.
    region: ?[]const u8,

    /// The name of the Amazon S3 stage that was created while setting up an Amazon
    /// S3 stage in the Snowflake account. This is written in the following format:
    /// .
    stage: []const u8,

    /// The name of the Snowflake warehouse.
    warehouse: []const u8,

    pub const json_field_names = .{
        .account_name = "accountName",
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .private_link_service_name = "privateLinkServiceName",
        .region = "region",
        .stage = "stage",
        .warehouse = "warehouse",
    };
};
