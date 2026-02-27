/// A tag is a label that you assign to a Timestream database and/or table. Each
/// tag consists of a key and an optional value, both of which you define. With
/// tags, you can
/// categorize databases and/or tables, for example, by purpose, owner, or
/// environment.
pub const Tag = struct {
    /// The key of the tag. Tag keys are case sensitive.
    key: []const u8,

    /// The value of the tag. Tag values are case-sensitive and can be null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
