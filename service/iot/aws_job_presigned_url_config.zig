/// Configuration information for pre-signed URLs. Valid when `protocols`
/// contains HTTP.
pub const AwsJobPresignedUrlConfig = struct {
    /// How long (in seconds) pre-signed URLs are valid. Valid values are 60 - 3600,
    /// the default value is 1800
    /// seconds. Pre-signed URLs are generated when a request for the job document
    /// is received.
    expires_in_sec: ?i64 = null,

    pub const json_field_names = .{
        .expires_in_sec = "expiresInSec",
    };
};
