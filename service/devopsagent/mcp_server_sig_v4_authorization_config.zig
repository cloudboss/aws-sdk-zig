const aws = @import("aws");

/// Authorization configuration for SigV4-authenticated MCP server.
pub const MCPServerSigV4AuthorizationConfig = struct {
    /// Custom headers for the SigV4 MCP server.
    custom_headers: ?[]const aws.map.StringMapEntry = null,

    /// IAM role ARN to assume for SigV4 signing. Optional — when omitted,
    /// credentials are resolved at runtime via a monitor account association.
    mcp_role_arn: ?[]const u8 = null,

    /// AWS region for SigV4 signing. Use '*' for SigV4a multi-region signing.
    region: []const u8,

    /// Deprecated — use mcpRoleArn instead. IAM role ARN to assume for SigV4
    /// signing.
    role_arn: []const u8 = "",

    /// AWS service name for SigV4 signing.
    service: []const u8,

    pub const json_field_names = .{
        .custom_headers = "customHeaders",
        .mcp_role_arn = "mcpRoleArn",
        .region = "region",
        .role_arn = "roleArn",
        .service = "service",
    };
};
