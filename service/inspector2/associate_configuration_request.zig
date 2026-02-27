const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;

/// Contains details about a request to associate a code repository with a scan
/// configuration.
pub const AssociateConfigurationRequest = struct {
    resource: CodeSecurityResource,

    /// The Amazon Resource Name (ARN) of the scan configuration.
    scan_configuration_arn: []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .scan_configuration_arn = "scanConfigurationArn",
    };
};
