/// The category that applies to a given label.
pub const LabelCategory = struct {
    /// The name of a category that applies to a given label.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
