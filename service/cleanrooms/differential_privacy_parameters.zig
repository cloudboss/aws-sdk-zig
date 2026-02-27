const DifferentialPrivacySensitivityParameters = @import("differential_privacy_sensitivity_parameters.zig").DifferentialPrivacySensitivityParameters;

/// An array that contains the sensitivity parameters.
pub const DifferentialPrivacyParameters = struct {
    /// Provides the sensitivity parameters that you can use to better understand
    /// the total amount of noise in query results.
    sensitivity_parameters: []const DifferentialPrivacySensitivityParameters,

    pub const json_field_names = .{
        .sensitivity_parameters = "sensitivityParameters",
    };
};
