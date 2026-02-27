const OriginGroup = @import("origin_group.zig").OriginGroup;

/// A complex data type for the origin groups specified for a distribution.
pub const OriginGroups = struct {
    /// The items (origin groups) in a distribution.
    items: ?[]const OriginGroup,

    /// The number of origin groups.
    quantity: i32,
};
