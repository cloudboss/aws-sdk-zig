/// SigV4 authorization configuration for remote A2A agent.
pub const RemoteAgentSigV4AuthorizationConfig = struct {
    region: []const u8,

    role_arn: ?[]const u8 = null,

    /// The AWS service name for SigV4 signing.
    service: []const u8,

    pub const json_field_names = .{
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
