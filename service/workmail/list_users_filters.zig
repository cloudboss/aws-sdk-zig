const EntityState = @import("entity_state.zig").EntityState;

/// Filtering options for *ListUsers* operation. This is only used as input to
/// Operation.
pub const ListUsersFilters = struct {
    /// Filters only users with the provided display name prefix.
    display_name_prefix: ?[]const u8,

    /// Filters only users with the ID from the IAM Identity Center.
    identity_provider_user_id_prefix: ?[]const u8,

    /// Filters only users with the provided email prefix.
    primary_email_prefix: ?[]const u8,

    /// Filters only users with the provided state.
    state: ?EntityState,

    /// Filters only users with the provided username prefix.
    username_prefix: ?[]const u8,

    pub const json_field_names = .{
        .display_name_prefix = "DisplayNamePrefix",
        .identity_provider_user_id_prefix = "IdentityProviderUserIdPrefix",
        .primary_email_prefix = "PrimaryEmailPrefix",
        .state = "State",
        .username_prefix = "UsernamePrefix",
    };
};
