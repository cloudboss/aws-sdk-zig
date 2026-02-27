const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;

/// Contains details about a request to disassociate a code repository from a
/// scan
/// configuration.
pub const DisassociateConfigurationRequest = struct {
    resource: CodeSecurityResource,

    /// The Amazon Resource Name (ARN) of the scan configuration to disassociate
    /// from a code
    /// repository.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .scan_configuration_arn = "scanConfigurationArn",
    };
};
