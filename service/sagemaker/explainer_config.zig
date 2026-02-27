const ClarifyExplainerConfig = @import("clarify_explainer_config.zig").ClarifyExplainerConfig;

/// A parameter to activate explainers.
pub const ExplainerConfig = struct {
    /// A member of `ExplainerConfig` that contains configuration parameters for the
    /// SageMaker Clarify explainer.
    clarify_explainer_config: ?ClarifyExplainerConfig,

    pub const json_field_names = .{
        .clarify_explainer_config = "ClarifyExplainerConfig",
    };
};
