const ParameterRange = @import("parameter_range.zig").ParameterRange;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Defines a hyperparameter to be used by an algorithm.
pub const HyperParameterSpecification = struct {
    /// The default value for this hyperparameter. If a default value is specified,
    /// a hyperparameter cannot be required.
    default_value: ?[]const u8,

    /// A brief description of the hyperparameter.
    description: ?[]const u8,

    /// Indicates whether this hyperparameter is required.
    is_required: ?bool,

    /// Indicates whether this hyperparameter is tunable in a hyperparameter tuning
    /// job.
    is_tunable: ?bool,

    /// The name of this hyperparameter. The name must be unique.
    name: []const u8,

    /// The allowed range for this hyperparameter.
    range: ?ParameterRange,

    /// The type of this hyperparameter. The valid types are `Integer`,
    /// `Continuous`, `Categorical`, and `FreeText`.
    @"type": ParameterType,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .is_required = "IsRequired",
        .is_tunable = "IsTunable",
        .name = "Name",
        .range = "Range",
        .@"type" = "Type",
    };
};
