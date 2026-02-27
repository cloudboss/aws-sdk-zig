/// A structure representing the datatype of the value.
pub const Datatype = struct {
    /// The datatype of the value.
    id: []const u8,

    /// A label assigned to the datatype.
    label: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .label = "Label",
    };
};
