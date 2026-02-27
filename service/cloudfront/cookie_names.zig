/// Contains a list of cookie names.
pub const CookieNames = struct {
    /// A list of cookie names.
    items: ?[]const []const u8,

    /// The number of cookie names in the `Items` list.
    quantity: i32,
};
