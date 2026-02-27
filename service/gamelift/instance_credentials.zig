/// A set of credentials that allow remote access to an instance in an EC2
/// managed fleet.
/// These credentials are returned in response to a call to
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetInstanceAccess](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetInstanceAccess), which requests access for instances that are running
/// game servers with the Amazon GameLift Servers server SDK version 4.x or
/// earlier.
pub const InstanceCredentials = struct {
    /// Secret string. For Windows instances, the secret is a password for use with
    /// Windows
    /// Remote Desktop. For Linux instances, it's a private key for use with SSH.
    secret: ?[]const u8,

    /// A user name for logging in.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .secret = "Secret",
        .user_name = "UserName",
    };
};
