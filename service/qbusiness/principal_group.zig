const ReadAccessType = @import("read_access_type.zig").ReadAccessType;
const MembershipType = @import("membership_type.zig").MembershipType;

/// Provides information about a group associated with the principal.
pub const PrincipalGroup = struct {
    /// Provides information about whether to allow or deny access to the principal.
    access: ReadAccessType,

    /// The type of group.
    membership_type: ?MembershipType,

    /// The name of the group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .access = "access",
        .membership_type = "membershipType",
        .name = "name",
    };
};
