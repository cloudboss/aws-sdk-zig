/// Information about the Amazon S3 Glue Data Catalog.
pub const S3GlueDataCatalog = struct {
    /// >The Amazon Resource Name (ARN) for the S3 Glue Data Catalog.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
    };
};
