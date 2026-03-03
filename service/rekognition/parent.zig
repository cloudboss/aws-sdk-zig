/// A parent label for a label. A label can have 0, 1, or more parents.
pub const Parent = struct {
    /// The name of the parent label.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
