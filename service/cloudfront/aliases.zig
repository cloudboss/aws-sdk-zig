/// A complex type that contains information about CNAMEs (alternate domain
/// names), if any, for this distribution.
pub const Aliases = struct {
    /// A complex type that contains the CNAME aliases, if any, that you want to
    /// associate with this distribution.
    items: ?[]const []const u8,

    /// The number of CNAME aliases, if any, that you want to associate with this
    /// distribution.
    quantity: i32,
};
