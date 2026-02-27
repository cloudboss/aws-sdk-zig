const CategoricalScaleDefinition = @import("categorical_scale_definition.zig").CategoricalScaleDefinition;
const NumericalScaleDefinition = @import("numerical_scale_definition.zig").NumericalScaleDefinition;

/// The rating scale that defines how evaluators should score agent performance,
/// supporting both numerical and categorical scales.
pub const RatingScale = union(enum) {
    /// The categorical rating scale with named categories and definitions for
    /// qualitative evaluation.
    categorical: ?[]const CategoricalScaleDefinition,
    /// The numerical rating scale with defined score values and descriptions for
    /// quantitative evaluation.
    numerical: ?[]const NumericalScaleDefinition,

    pub const json_field_names = .{
        .categorical = "categorical",
        .numerical = "numerical",
    };
};
