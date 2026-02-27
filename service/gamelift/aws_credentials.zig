/// Amazon Web Services account security credentials that allow interactions
/// with Amazon GameLift Servers resources. The
/// credentials are temporary and valid for a limited time span. You can request
/// fresh
/// credentials at any time.
///
/// Amazon Web Services security credentials consist of three parts: an access
/// key ID, a secret access
/// key, and a session token. You must use all three parts together to
/// authenticate your
/// access requests.
///
/// You need Amazon Web Services credentials for the following tasks:
///
/// * To upload a game server build directly to Amazon GameLift Servers S3
///   storage using `CreateBuild`. To get access for this
/// task, call
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_RequestUploadCredentials.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_RequestUploadCredentials.html).
///
/// * To remotely connect to an active Amazon GameLift Servers fleet instances.
/// To get remote access, call
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetComputeAccess.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetComputeAccess.html).
pub const AwsCredentials = struct {
    /// The access key ID that identifies the temporary security credentials.
    access_key_id: ?[]const u8,

    /// The secret access key that can be used to sign requests.
    secret_access_key: ?[]const u8,

    /// The token that users must pass to the service API to use the temporary
    /// credentials.
    session_token: ?[]const u8,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .secret_access_key = "SecretAccessKey",
        .session_token = "SessionToken",
    };
};
