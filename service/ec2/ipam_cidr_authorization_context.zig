/// A signed document that proves that you are authorized to bring the specified
/// IP address range to Amazon using BYOIP.
pub const IpamCidrAuthorizationContext = struct {
    /// The plain-text authorization message for the prefix and account.
    message: ?[]const u8 = null,

    /// The signed authorization message for the prefix and account.
    signature: ?[]const u8 = null,
};
