/// Contains details about the validation token.
pub const ValidationTokenDetail = struct {
    /// The domain name.
    domain: []const u8,

    /// The domain to redirect from.
    redirect_from: ?[]const u8,

    /// The domain to redirect to.
    redirect_to: ?[]const u8,
};
