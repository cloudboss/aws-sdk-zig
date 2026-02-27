const FieldValue = @import("field_value.zig").FieldValue;

/// The `CreateCase` action definition.
pub const CreateCaseActionDefinition = struct {
    /// An array of objects with `Field ID` and `Value` data.
    fields: []const FieldValue,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .fields = "Fields",
        .template_id = "TemplateId",
    };
};
