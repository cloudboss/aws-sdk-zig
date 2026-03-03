const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;

/// Details about a successful association or disassociation between a code
/// repository and a
/// scan configuration.
pub const SuccessfulAssociationResult = struct {
    resource: ?CodeSecurityResource = null,

    /// The Amazon Resource Name (ARN) of the scan configuration that was
    /// successfully
    /// associated or disassociated.
    scan_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource = "resource",
        .scan_configuration_arn = "scanConfigurationArn",
    };
};
