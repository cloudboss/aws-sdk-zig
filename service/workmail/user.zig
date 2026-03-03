const EntityState = @import("entity_state.zig").EntityState;
const UserRole = @import("user_role.zig").UserRole;

/// The representation of an WorkMail user.
pub const User = struct {
    /// The date indicating when the user was disabled from WorkMail use.
    disabled_date: ?i64 = null,

    /// The display name of the user.
    display_name: ?[]const u8 = null,

    /// The email of the user.
    email: ?[]const u8 = null,

    /// The date indicating when the user was enabled for WorkMail use.
    enabled_date: ?i64 = null,

    /// The identifier of the user.
    id: ?[]const u8 = null,

    /// Identity store ID from the IAM Identity Center. If this parameter is empty
    /// it will be updated automatically when the user logs in for the first time to
    /// the mailbox associated with WorkMail.
    identity_provider_identity_store_id: ?[]const u8 = null,

    /// User ID from the IAM Identity Center. If this parameter is empty it will be
    /// updated automatically when the user logs in for the first time to the
    /// mailbox associated with WorkMail.
    identity_provider_user_id: ?[]const u8 = null,

    /// The name of the user.
    name: ?[]const u8 = null,

    /// The state of the user, which can be ENABLED, DISABLED, or DELETED.
    state: ?EntityState = null,

    /// The role of the user.
    user_role: ?UserRole = null,

    pub const json_field_names = .{
        .disabled_date = "DisabledDate",
        .display_name = "DisplayName",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .id = "Id",
        .identity_provider_identity_store_id = "IdentityProviderIdentityStoreId",
        .identity_provider_user_id = "IdentityProviderUserId",
        .name = "Name",
        .state = "State",
        .user_role = "UserRole",
    };
};
