/// Details about the fields such as name of the field.
pub const FieldInfo = struct {
    /// Name of the field.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
