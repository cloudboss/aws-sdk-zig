const aws = @import("aws");

/// Details specific to a registered SigV4-authenticated MCP server.
pub const RegisteredMCPServerSigV4Details = struct {
    /// Custom headers for the SigV4 MCP server.
    custom_headers: ?[]const aws.map.StringMapEntry = null,

    /// Optional description for the MCP server.
    description: ?[]const u8 = null,

    /// MCP server endpoint URL.
    endpoint: []const u8,

    mcp_role_arn: ?[]const u8 = null,

    /// MCP server name.
    name: []const u8,

    /// AWS region for SigV4 signing. Use '*' for SigV4a multi-region signing.
    region: []const u8,

    /// IAM role ARN to assume for SigV4 signing.
    role_arn: []const u8 = "",

    /// AWS service name for SigV4 signing.
    service: []const u8,

    pub const json_field_names = .{
        .custom_headers = "customHeaders",
        .description = "description",
        .endpoint = "endpoint",
        .mcp_role_arn = "mcpRoleArn",
        .name = "name",
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
