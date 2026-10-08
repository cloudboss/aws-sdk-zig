const UserMetadata = @import("user_metadata.zig").UserMetadata;

/// Contains metadata about a member. This is a union type that contains
/// member-type-specific metadata.
pub const MemberMetadata = union(enum) {
    /// The user metadata for the member.
    user: ?UserMetadata,

    pub const json_field_names = .{
        .user = "user",
    };
};
