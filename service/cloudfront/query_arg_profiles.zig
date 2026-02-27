const QueryArgProfile = @import("query_arg_profile.zig").QueryArgProfile;

/// Query argument-profile mapping for field-level encryption.
pub const QueryArgProfiles = struct {
    /// Number of items for query argument-profile mapping for field-level
    /// encryption.
    items: ?[]const QueryArgProfile,

    /// Number of profiles for query argument-profile mapping for field-level
    /// encryption.
    quantity: i32,
};
