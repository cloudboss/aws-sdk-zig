const GroupProfileStatus = @import("group_profile_status.zig").GroupProfileStatus;

/// The details of a group profile.
pub const GroupProfileSummary = struct {
    /// The ID of the Amazon DataZone domain of a group profile.
    domain_id: ?[]const u8 = null,

    /// The group name of a group profile.
    group_name: ?[]const u8 = null,

    /// The ID of a group profile.
    id: ?[]const u8 = null,

    /// The ARN of the IAM role principal. This role is associated with the group
    /// profile.
    role_principal_arn: ?[]const u8 = null,

    /// The unique identifier of the IAM role principal. This principal is
    /// associated with the group profile.
    role_principal_id: ?[]const u8 = null,

    /// The status of a group profile.
    status: ?GroupProfileStatus = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .group_name = "groupName",
        .id = "id",
        .role_principal_arn = "rolePrincipalArn",
        .role_principal_id = "rolePrincipalId",
        .status = "status",
    };
};
