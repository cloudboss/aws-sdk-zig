const GlueConfiguration = @import("glue_configuration.zig").GlueConfiguration;

/// Configuration information for delivery of dataset contents to Amazon Simple
/// Storage Service (Amazon S3).
pub const S3DestinationConfiguration = struct {
    /// The name of the S3 bucket to which dataset contents are delivered.
    bucket: []const u8,

    /// Configuration information for coordination with Glue, a fully managed
    /// extract, transform
    /// and load (ETL) service.
    glue_configuration: ?GlueConfiguration,

    /// The key of the dataset contents object in an S3 bucket. Each object has a
    /// key that is a
    /// unique identifier. Each object has exactly one key.
    ///
    /// You can create a unique key with the following options:
    ///
    /// * Use `!{iotanalytics:scheduleTime}` to insert the time of a scheduled SQL
    /// query run.
    ///
    /// * Use `!{iotanalytics:versionId}` to insert a unique hash that identifies a
    /// dataset content.
    ///
    /// * Use `!{iotanalytics:creationTime}` to insert the creation time of a
    ///   dataset
    /// content.
    ///
    /// The following example creates a unique key for a CSV file:
    /// `dataset/mydataset/!{iotanalytics:scheduleTime}/!{iotanalytics:versionId}.csv`
    ///
    /// If you don't use `!{iotanalytics:versionId}` to specify the key, you might
    /// get duplicate keys. For example, you might have two dataset contents with
    /// the same
    /// `scheduleTime` but different `versionId`s. This means that one
    /// dataset content overwrites the other.
    key: []const u8,

    /// The ARN of the role that grants IoT Analytics permission to interact with
    /// your Amazon S3 and Glue
    /// resources.
    role_arn: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .glue_configuration = "glueConfiguration",
        .key = "key",
        .role_arn = "roleArn",
    };
};
