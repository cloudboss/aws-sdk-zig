/// A keyword filter for querying findings.
pub const KeywordFilter = struct {
    /// A value for the keyword.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
