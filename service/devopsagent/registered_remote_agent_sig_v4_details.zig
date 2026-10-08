/// Details specific to a registered SigV4-authenticated remote A2A agent.
pub const RegisteredRemoteAgentSigV4Details = struct {
    description: ?[]const u8 = null,

    endpoint: []const u8,

    name: []const u8,

    region: []const u8,

    role_arn: ?[]const u8 = null,

    /// The AWS service name for SigV4 signing.
    service: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
