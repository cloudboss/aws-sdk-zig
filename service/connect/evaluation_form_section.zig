const EvaluationFormItem = @import("evaluation_form_item.zig").EvaluationFormItem;

/// Information about a section from an evaluation form. A section can contain
/// sections and/or questions. Evaluation
/// forms can only contain sections and subsections (two level nesting).
pub const EvaluationFormSection = struct {
    /// The instructions of the section.
    instructions: ?[]const u8 = null,

    /// The items of the section.
    items: []const EvaluationFormItem,

    /// The identifier of the section. An identifier must be unique within the
    /// evaluation form.
    ref_id: []const u8,

    /// The title of the section.
    title: []const u8,

    /// The scoring weight of the section.
    weight: f64 = 0,

    pub const json_field_names = .{
        .instructions = "Instructions",
        .items = "Items",
        .ref_id = "RefId",
        .title = "Title",
        .weight = "Weight",
    };
};
