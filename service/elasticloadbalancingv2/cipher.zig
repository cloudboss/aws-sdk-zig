/// Information about a cipher used in a policy.
pub const Cipher = struct {
    /// The name of the cipher.
    name: ?[]const u8 = null,

    /// The priority of the cipher.
    priority: ?i32 = null,
};
