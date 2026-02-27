const LabelSchema = @import("label_schema.zig").LabelSchema;

/// The training data schema.
pub const TrainingDataSchema = struct {
    label_schema: ?LabelSchema,

    /// The training data schema variables.
    model_variables: []const []const u8,

    pub const json_field_names = .{
        .label_schema = "labelSchema",
        .model_variables = "modelVariables",
    };
};
