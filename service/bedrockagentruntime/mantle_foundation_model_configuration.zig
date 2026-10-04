const MantleFoundationModelModelConfiguration = @import("mantle_foundation_model_model_configuration.zig").MantleFoundationModelModelConfiguration;

/// Configuration for a Mantle foundation model.
pub const MantleFoundationModelConfiguration = struct {
    /// The model configuration containing the model ARN and project ID.
    model_configuration: MantleFoundationModelModelConfiguration,

    pub const json_field_names = .{
        .model_configuration = "modelConfiguration",
    };
};
