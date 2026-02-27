const ShareResourceType = @import("share_resource_type.zig").ShareResourceType;

/// The share invitation.
pub const ShareInvitation = struct {
    lens_alias: ?[]const u8,

    /// The ARN for the lens.
    lens_arn: ?[]const u8,

    /// The profile ARN.
    profile_arn: ?[]const u8,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8,

    /// The resource type of the share invitation.
    share_resource_type: ?ShareResourceType,

    /// The review template ARN.
    template_arn: ?[]const u8,

    workload_id: ?[]const u8,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .profile_arn = "ProfileArn",
        .share_invitation_id = "ShareInvitationId",
        .share_resource_type = "ShareResourceType",
        .template_arn = "TemplateArn",
        .workload_id = "WorkloadId",
    };
};
