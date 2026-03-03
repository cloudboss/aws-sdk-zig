const PermissionType = @import("permission_type.zig").PermissionType;
const ShareResourceType = @import("share_resource_type.zig").ShareResourceType;

/// A share invitation summary return object.
pub const ShareInvitationSummary = struct {
    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    lens_name: ?[]const u8 = null,

    permission_type: ?PermissionType = null,

    /// The profile ARN.
    profile_arn: ?[]const u8 = null,

    /// The profile name.
    profile_name: ?[]const u8 = null,

    shared_by: ?[]const u8 = null,

    shared_with: ?[]const u8 = null,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8 = null,

    /// The resource type of the share invitation.
    share_resource_type: ?ShareResourceType = null,

    /// The review template ARN.
    template_arn: ?[]const u8 = null,

    /// The name of the review template.
    template_name: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .lens_arn = "LensArn",
        .lens_name = "LensName",
        .permission_type = "PermissionType",
        .profile_arn = "ProfileArn",
        .profile_name = "ProfileName",
        .shared_by = "SharedBy",
        .shared_with = "SharedWith",
        .share_invitation_id = "ShareInvitationId",
        .share_resource_type = "ShareResourceType",
        .template_arn = "TemplateArn",
        .template_name = "TemplateName",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
