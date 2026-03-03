/// A structure that represents a negative format.
pub const NegativeFormat = struct {
    /// The prefix for a negative format.
    prefix: ?[]const u8 = null,

    /// The suffix for a negative format.
    suffix: ?[]const u8 = null,

    pub const json_field_names = .{
        .prefix = "Prefix",
        .suffix = "Suffix",
    };
};
