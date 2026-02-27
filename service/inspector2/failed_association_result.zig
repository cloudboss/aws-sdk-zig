const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;
const AssociationResultStatusCode = @import("association_result_status_code.zig").AssociationResultStatusCode;

/// Details about a failed attempt to associate or disassociate a code
/// repository with a
/// scan configuration.
pub const FailedAssociationResult = struct {
    resource: ?CodeSecurityResource,

    /// The Amazon Resource Name (ARN) of the scan configuration that failed to be
    /// associated or
    /// disassociated.
    scan_configuration_arn: ?[]const u8,

    /// The status code indicating why the association or disassociation failed.
    status_code: ?AssociationResultStatusCode,

    /// A message explaining why the association or disassociation failed.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .scan_configuration_arn = "scanConfigurationArn",
        .status_code = "statusCode",
        .status_message = "statusMessage",
    };
};
