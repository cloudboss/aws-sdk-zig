/// Whitelist rule
pub const InputWhitelistRule = struct {
    /// The IPv4 CIDR that's whitelisted.
    cidr: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
