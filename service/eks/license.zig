/// An EKS Anywhere license associated with a subscription.
pub const License = struct {
    /// An id associated with an EKS Anywhere subscription license.
    id: ?[]const u8,

    /// An optional license token that can be used for extended support
    /// verification.
    token: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .token = "token",
    };
};
