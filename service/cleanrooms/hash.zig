/// Hash
pub const Hash = struct {
    /// The SHA-256 hash value.
    sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .sha_256 = "sha256",
    };
};
