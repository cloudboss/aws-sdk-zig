const CustomExtractionConfigurationInput = @import("custom_extraction_configuration_input.zig").CustomExtractionConfigurationInput;

/// Contains information for modifying an extraction configuration.
pub const ModifyExtractionConfiguration = union(enum) {
    /// The updated custom extraction configuration.
    custom_extraction_configuration: ?CustomExtractionConfigurationInput,

    pub const json_field_names = .{
        .custom_extraction_configuration = "customExtractionConfiguration",
    };
};
