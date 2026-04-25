const PermissionConfiguration = @import("permission_configuration.zig").PermissionConfiguration;

/// Describes the public access policies that apply to the S3 bucket.
pub const PublicAccess = struct {
    /// Describes the effective permission on this bucket after factoring all
    /// attached policies.
    effective_permission: ?[]const u8 = null,

    /// Contains information about how permissions are configured for the S3 bucket.
    permission_configuration: ?PermissionConfiguration = null,

    pub const json_field_names = .{
        .effective_permission = "EffectivePermission",
        .permission_configuration = "PermissionConfiguration",
    };
};
