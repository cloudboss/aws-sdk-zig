/// IAM credential provider configuration for authenticating with an external
/// source using SigV4 signing during synchronization.
pub const RegistryRecordIamCredentialProvider = struct {
    /// The Amazon Web Services region for SigV4 signing (for example, `us-west-2`).
    /// If not specified, the region is extracted from the MCP server URL hostname,
    /// with fallback to the service's own region.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role to assume for SigV4 signing.
    role_arn: ?[]const u8 = null,

    /// The SigV4 signing service name (for example, `execute-api` or
    /// `bedrock-agentcore`).
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
