const BusinessNameGenerationConfiguration = @import("business_name_generation_configuration.zig").BusinessNameGenerationConfiguration;

/// The configuration of the prediction.
pub const PredictionConfiguration = struct {
    /// The business name generation mechanism.
    business_name_generation: ?BusinessNameGenerationConfiguration = null,

    pub const json_field_names = .{
        .business_name_generation = "businessNameGeneration",
    };
};
