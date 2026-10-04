const Architecture = @import("architecture.zig").Architecture;
const PackageType = @import("package_type.zig").PackageType;

/// Contains details about a serverless function involved in a finding.
pub const ServerlessFunction = struct {
    /// The architectures of the serverless function.
    architectures: ?[]const Architecture = null,

    /// The code digest of the serverless function.
    code_digest: ?[]const u8 = null,

    /// The execution role of the serverless function.
    execution_role: ?[]const u8 = null,

    /// The date and time the serverless function was last modified.
    last_modified_at: ?i64 = null,

    /// The layers of the serverless function.
    layers: ?[]const []const u8 = null,

    /// The network ID associated with the serverless function.
    network_id: ?[]const u8 = null,

    /// The package type of the serverless function.
    package_type: ?PackageType = null,

    /// The runtime of the serverless function.
    runtime: ?[]const u8 = null,

    /// The security group IDs associated with the serverless function.
    security_group_ids: ?[]const []const u8 = null,

    /// The name of the serverless function.
    serverless_function_name: ?[]const u8 = null,

    /// The subnet IDs associated with the serverless function.
    subnet_ids: ?[]const []const u8 = null,

    /// The version of the serverless function.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .architectures = "architectures",
        .code_digest = "codeDigest",
        .execution_role = "executionRole",
        .last_modified_at = "lastModifiedAt",
        .layers = "layers",
        .network_id = "networkId",
        .package_type = "packageType",
        .runtime = "runtime",
        .security_group_ids = "securityGroupIds",
        .serverless_function_name = "serverlessFunctionName",
        .subnet_ids = "subnetIds",
        .version = "version",
    };
};
