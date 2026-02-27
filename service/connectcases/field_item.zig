/// Object for field related information.
pub const FieldItem = struct {
    /// Unique identifier of a field.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
