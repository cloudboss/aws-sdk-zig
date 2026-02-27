const S3Config = @import("s3_config.zig").S3Config;

/// The destination for an export job. Provide an S3 path, an Identity and
/// Access Management (IAM) role that allows Amazon Forecast
/// to access the location, and an Key Management Service (KMS) key (optional).
pub const DataDestination = struct {
    /// The path to an Amazon Simple Storage Service (Amazon S3) bucket along with
    /// the credentials to access the
    /// bucket.
    s3_config: S3Config,

    pub const json_field_names = .{
        .s3_config = "S3Config",
    };
};
