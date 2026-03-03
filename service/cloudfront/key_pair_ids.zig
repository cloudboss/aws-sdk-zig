/// A list of CloudFront key pair identifiers.
pub const KeyPairIds = struct {
    /// A list of CloudFront key pair identifiers.
    items: ?[]const []const u8 = null,

    /// The number of key pair identifiers in the list.
    quantity: i32,
};
