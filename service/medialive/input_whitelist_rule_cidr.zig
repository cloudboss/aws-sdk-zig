/// An IPv4 CIDR to whitelist.
pub const InputWhitelistRuleCidr = struct {
    /// The IPv4 CIDR to whitelist.
    cidr: ?[]const u8,

    pub const json_field_names = .{
        .cidr = "Cidr",
    };
};
