const CustomExtractionConfiguration = @import("custom_extraction_configuration.zig").CustomExtractionConfiguration;

/// Contains extraction configuration information for a memory strategy.
pub const ExtractionConfiguration = union(enum) {
    /// The custom extraction configuration.
    custom_extraction_configuration: ?CustomExtractionConfiguration,

    pub const json_field_names = .{
        .custom_extraction_configuration = "customExtractionConfiguration",
    };
};
