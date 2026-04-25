/// The parameters for S3 Tables.
pub const S3TablesParameters = struct {
    /// The Amazon Resource Name (ARN) of the S3 Tables bucket.
    table_bucket_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .table_bucket_arn = "TableBucketArn",
    };
};
