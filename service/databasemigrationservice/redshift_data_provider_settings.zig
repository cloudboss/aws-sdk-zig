/// Provides information that defines an Amazon Redshift data provider.
pub const RedshiftDataProviderSettings = struct {
    /// The database name on the Amazon Redshift data provider.
    database_name: ?[]const u8,

    /// The port value for the Amazon Redshift data provider.
    port: ?i32,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8,

    /// The name of the Amazon Redshift server.
    server_name: ?[]const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .port = "Port",
        .s3_access_role_arn = "S3AccessRoleArn",
        .s3_path = "S3Path",
        .server_name = "ServerName",
    };
};
