const S3ContentBaseLocation = @import("s3_content_base_location.zig").S3ContentBaseLocation;

/// The information required to deploy a Managed Service for Apache Flink Studio
/// notebook as an application with durable state.
pub const DeployAsApplicationConfiguration = struct {
    /// The description of an Amazon S3 object that contains the Amazon Data
    /// Analytics application, including the Amazon Resource Name (ARN) of the S3
    /// bucket, the name of the Amazon S3 object that contains the data, and the
    /// version number of the Amazon S3 object that contains the data.
    s3_content_location: S3ContentBaseLocation,

    pub const json_field_names = .{
        .s3_content_location = "S3ContentLocation",
    };
};
