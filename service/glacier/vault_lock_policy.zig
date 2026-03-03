/// Contains the vault lock policy.
pub const VaultLockPolicy = struct {
    /// The vault lock policy.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};
