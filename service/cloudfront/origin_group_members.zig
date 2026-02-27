const OriginGroupMember = @import("origin_group_member.zig").OriginGroupMember;

/// A complex data type for the origins included in an origin group.
pub const OriginGroupMembers = struct {
    /// Items (origins) in an origin group.
    items: []const OriginGroupMember,

    /// The number of origins in an origin group.
    quantity: i32,
};
