/// List of fields that must have a value provided to create a case.
pub const RequiredField = struct {
    /// Unique identifier of a field.
    field_id: []const u8,

    pub const json_field_names = .{
        .field_id = "fieldId",
    };
};
