/// A potential alias of for a given label.
pub const LabelAlias = struct {
    /// The name of an alias for a given label.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
