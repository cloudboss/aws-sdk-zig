const ReadAccessType = @import("read_access_type.zig").ReadAccessType;
const MembershipType = @import("membership_type.zig").MembershipType;

/// Provides information about a user associated with a principal.
pub const PrincipalUser = struct {
    /// Provides information about whether to allow or deny access to the principal.
    access: ReadAccessType,

    /// The identifier of the user.
    id: ?[]const u8,

    /// The type of group.
    membership_type: ?MembershipType,

    pub const json_field_names = .{
        .access = "access",
        .id = "id",
        .membership_type = "membershipType",
    };
};
