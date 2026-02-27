/// The authorization configuration details for Amazon FSx for Windows File
/// Server file
/// system. See
/// [FSxWindowsFileServerVolumeConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FSxWindowsFileServerVolumeConfiguration.html) in the *Amazon ECS API
/// Reference*.
///
/// For more information and the input format, see [Amazon FSx for Windows File
/// Server
/// Volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the *Amazon Elastic Container Service Developer
/// Guide*.
pub const FSxWindowsFileServerAuthorizationConfig = struct {
    /// The authorization credential option to use. The authorization credential
    /// options can
    /// be provided using either the Amazon Resource Name (ARN) of an Secrets
    /// Manager secret or SSM
    /// Parameter Store parameter. The ARN refers to the stored credentials.
    credentials_parameter: []const u8,

    /// A fully qualified domain name hosted by an [Directory
    /// Service](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_microsoft_ad.html) Managed Microsoft AD (Active Directory) or self-hosted
    /// AD on Amazon EC2.
    domain: []const u8,

    pub const json_field_names = .{
        .credentials_parameter = "credentialsParameter",
        .domain = "domain",
    };
};
