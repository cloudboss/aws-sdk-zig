/// Contains a list of HTTP header names.
pub const Headers = struct {
    /// A list of HTTP header names.
    items: ?[]const []const u8 = null,

    /// The number of header names in the `Items` list.
    quantity: i32,
};
