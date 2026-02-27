const S3Config = @import("s3_config.zig").S3Config;

/// The source of your data, an Identity and Access Management (IAM) role that
/// allows Amazon Forecast to
/// access the data and, optionally, an Key Management Service (KMS) key.
pub const DataSource = struct {
    /// The path to the data stored in an Amazon Simple Storage Service (Amazon S3)
    /// bucket along with the
    /// credentials to access the data.
    s3_config: S3Config,

    pub const json_field_names = .{
        .s3_config = "S3Config",
    };
};
