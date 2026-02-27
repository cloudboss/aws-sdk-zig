/// Represents an Amazon Web Services session credentials object. These
/// credentials are
/// temporary credentials that are issued by Amazon Web Services Secure Token
/// Service (STS).
/// They can be used to access input and output artifacts in the S3 bucket used
/// to store
/// artifact for the pipeline in CodePipeline.
pub const AWSSessionCredentials = struct {
    /// The access key for the session.
    access_key_id: []const u8,

    /// The secret access key for the session.
    secret_access_key: []const u8,

    /// The token for the session.
    session_token: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
