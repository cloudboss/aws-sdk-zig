const DifferentialPrivacyPreviewParametersInput = @import("differential_privacy_preview_parameters_input.zig").DifferentialPrivacyPreviewParametersInput;

/// Specifies the updated epsilon and noise parameters to preview. The preview
/// allows you to see how the maximum number of each type of aggregation
/// function would change with the new parameters.
pub const PreviewPrivacyImpactParametersInput = union(enum) {
    /// An array that specifies the epsilon and noise parameters.
    differential_privacy: ?DifferentialPrivacyPreviewParametersInput,

    pub const json_field_names = .{
        .differential_privacy = "differentialPrivacy",
    };
};
