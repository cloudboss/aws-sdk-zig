/// Object for unique identifier of a field.
pub const FieldIdentifier = struct {
    /// Unique identifier of a field.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
