/// Contains a list of query string names.
pub const QueryStringNames = struct {
    /// A list of query string names.
    items: ?[]const []const u8 = null,

    /// The number of query string names in the `Items` list.
    quantity: i32,
};
