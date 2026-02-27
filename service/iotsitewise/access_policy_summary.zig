const Identity = @import("identity.zig").Identity;
const Permission = @import("permission.zig").Permission;
const Resource = @import("resource.zig").Resource;

/// Contains an access policy that defines an identity's access to an IoT
/// SiteWise Monitor
/// resource.
pub const AccessPolicySummary = struct {
    /// The date the access policy was created, in Unix epoch time.
    creation_date: ?i64,

    /// The ID of the access policy.
    id: []const u8,

    /// The identity (an IAM Identity Center user, an IAM Identity Center group, or
    /// an IAM user).
    identity: Identity,

    /// The date the access policy was last updated, in Unix epoch time.
    last_update_date: ?i64,

    /// The permissions for the access policy. Note that a project `ADMINISTRATOR`
    /// is
    /// also known as a project owner.
    permission: Permission,

    /// The IoT SiteWise Monitor resource (a portal or project).
    resource: Resource,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .id = "id",
        .identity = "identity",
        .last_update_date = "lastUpdateDate",
        .permission = "permission",
        .resource = "resource",
    };
};
