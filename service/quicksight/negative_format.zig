/// A structure that represents a negative format.
pub const NegativeFormat = struct {
    /// The prefix for a negative format.
    prefix: ?[]const u8,

    /// The suffix for a negative format.
    suffix: ?[]const u8,

    pub const json_field_names = .{
        .prefix = "Prefix",
        .suffix = "Suffix",
    };
};
