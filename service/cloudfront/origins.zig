const Origin = @import("origin.zig").Origin;

/// Contains information about the origins for this distribution.
pub const Origins = struct {
    /// A list of origins.
    items: []const Origin,

    /// The number of origins for this distribution.
    quantity: i32,
};
