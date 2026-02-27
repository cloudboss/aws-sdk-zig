const FieldValue = @import("field_value.zig").FieldValue;

/// The `UpdateCase` action definition.
pub const UpdateCaseActionDefinition = struct {
    /// An array of objects with `Field ID` and Value data.
    fields: []const FieldValue,

    pub const json_field_names = .{
        .fields = "Fields",
    };
};
