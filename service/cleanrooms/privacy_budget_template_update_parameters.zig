const AccessBudgetsPrivacyTemplateUpdateParameters = @import("access_budgets_privacy_template_update_parameters.zig").AccessBudgetsPrivacyTemplateUpdateParameters;
const DifferentialPrivacyTemplateUpdateParameters = @import("differential_privacy_template_update_parameters.zig").DifferentialPrivacyTemplateUpdateParameters;

/// The epsilon and noise parameters that you want to update in the privacy
/// budget template.
pub const PrivacyBudgetTemplateUpdateParameters = union(enum) {
    /// The new access budget configuration that completely replaces the existing
    /// access budget settings in the privacy budget template.
    access_budget: ?AccessBudgetsPrivacyTemplateUpdateParameters,
    /// An object that specifies the new values for the epsilon and noise
    /// parameters.
    differential_privacy: ?DifferentialPrivacyTemplateUpdateParameters,

    pub const json_field_names = .{
        .access_budget = "accessBudget",
        .differential_privacy = "differentialPrivacy",
    };
};
