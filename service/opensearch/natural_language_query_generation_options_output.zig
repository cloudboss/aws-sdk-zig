const NaturalLanguageQueryGenerationCurrentState = @import("natural_language_query_generation_current_state.zig").NaturalLanguageQueryGenerationCurrentState;
const NaturalLanguageQueryGenerationDesiredState = @import("natural_language_query_generation_desired_state.zig").NaturalLanguageQueryGenerationDesiredState;

/// Container for parameters representing the state of the natural language
/// query
/// generation feature on the specified domain.
pub const NaturalLanguageQueryGenerationOptionsOutput = struct {
    /// The current state of the natural language query generation feature,
    /// indicating
    /// completion, in progress, or failure.
    current_state: ?NaturalLanguageQueryGenerationCurrentState = null,

    /// The desired state of the natural language query generation feature. Valid
    /// values are
    /// ENABLED and DISABLED.
    desired_state: ?NaturalLanguageQueryGenerationDesiredState = null,

    pub const json_field_names = .{
        .current_state = "CurrentState",
        .desired_state = "DesiredState",
    };
};
