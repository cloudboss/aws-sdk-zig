const AllowedOperation = @import("allowed_operation.zig").AllowedOperation;
const GrantStatus = @import("grant_status.zig").GrantStatus;
const Options = @import("options.zig").Options;

/// Describes a grant.
pub const Grant = struct {
    /// Amazon Resource Name (ARN) of the grant.
    grant_arn: []const u8,

    /// Granted operations.
    granted_operations: []const AllowedOperation,

    /// The grantee principal ARN.
    grantee_principal_arn: []const u8,

    /// Grant name.
    grant_name: []const u8,

    /// Grant status.
    grant_status: GrantStatus,

    /// Home Region of the grant.
    home_region: []const u8,

    /// License ARN.
    license_arn: []const u8,

    /// The options specified for the grant.
    options: ?Options,

    /// Parent ARN.
    parent_arn: []const u8,

    /// Grant status reason.
    status_reason: ?[]const u8,

    /// Grant version.
    version: []const u8,

    pub const json_field_names = .{
        .grant_arn = "GrantArn",
        .granted_operations = "GrantedOperations",
        .grantee_principal_arn = "GranteePrincipalArn",
        .grant_name = "GrantName",
        .grant_status = "GrantStatus",
        .home_region = "HomeRegion",
        .license_arn = "LicenseArn",
        .options = "Options",
        .parent_arn = "ParentArn",
        .status_reason = "StatusReason",
        .version = "Version",
    };
};
