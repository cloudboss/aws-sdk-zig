/// Contains the vault access policy.
pub const VaultAccessPolicy = struct {
    /// The vault access policy.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};
