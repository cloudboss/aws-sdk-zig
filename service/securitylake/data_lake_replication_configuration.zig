/// Provides replication details for objects stored in the Amazon Security Lake
/// data lake.
pub const DataLakeReplicationConfiguration = struct {
    /// Specifies one or more centralized rollup Regions. The Amazon Web Services
    /// Region specified in the `region`
    /// parameter of the [
    /// `CreateDataLake`
    /// ](https://docs.aws.amazon.com/security-lake/latest/APIReference/API_CreateDataLake.html)
    /// or [
    /// `UpdateDataLake`
    /// ](https://docs.aws.amazon.com/security-lake/latest/APIReference/API_UpdateDataLake.html) operations contributes data to the rollup Region or
    /// Regions specified in this parameter.
    ///
    /// Replication enables automatic, asynchronous copying of objects across Amazon
    /// S3
    /// buckets. S3 buckets that are configured for object replication can be owned
    /// by the same Amazon Web Services account or by different accounts. You can
    /// replicate objects
    /// to a single destination bucket or to multiple destination buckets. The
    /// destination buckets
    /// can be in different Regions or within the same Region as the source bucket.
    regions: ?[]const []const u8,

    /// Replication settings for the Amazon S3 buckets. This parameter uses the
    /// Identity and Access Management (IAM) role you created that is managed by
    /// Security Lake, to
    /// ensure the replication setting is correct.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .regions = "regions",
        .role_arn = "roleArn",
    };
};
