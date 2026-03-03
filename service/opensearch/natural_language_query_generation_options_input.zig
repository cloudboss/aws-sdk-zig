const NaturalLanguageQueryGenerationDesiredState = @import("natural_language_query_generation_desired_state.zig").NaturalLanguageQueryGenerationDesiredState;

/// Container for parameters required to enable the natural language query
/// generation
/// feature.
pub const NaturalLanguageQueryGenerationOptionsInput = struct {
    /// The desired state of the natural language query generation feature. Valid
    /// values are
    /// ENABLED and DISABLED.
    desired_state: ?NaturalLanguageQueryGenerationDesiredState = null,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
    };
};
