const ImpersonationRoleType = @import("impersonation_role_type.zig").ImpersonationRoleType;

/// An impersonation role for the given WorkMail organization.
pub const ImpersonationRole = struct {
    /// The date when the impersonation role was created.
    date_created: ?i64 = null,

    /// The date when the impersonation role was last modified.
    date_modified: ?i64 = null,

    /// The identifier of the impersonation role.
    impersonation_role_id: ?[]const u8 = null,

    /// The impersonation role name.
    name: ?[]const u8 = null,

    /// The impersonation role type.
    @"type": ?ImpersonationRoleType = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .impersonation_role_id = "ImpersonationRoleId",
        .name = "Name",
        .@"type" = "Type",
    };
};
