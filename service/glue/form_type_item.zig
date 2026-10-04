/// A summary of a form type.
pub const FormTypeItem = struct {
    /// The identifier of the form type.
    id: ?[]const u8 = null,

    /// The name of the form type.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
