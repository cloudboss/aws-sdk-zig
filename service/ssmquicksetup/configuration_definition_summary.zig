const aws = @import("aws");

/// A summarized definition of a Quick Setup configuration definition.
pub const ConfigurationDefinitionSummary = struct {
    /// The common parameters and values for the configuration definition.
    first_class_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the configuration definition.
    id: ?[]const u8 = null,

    /// The type of the Quick Setup configuration used by the configuration
    /// definition.
    @"type": ?[]const u8 = null,

    /// The version of the Quick Setup type used by the configuration definition.
    type_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_class_parameters = "FirstClassParameters",
        .id = "Id",
        .@"type" = "Type",
        .type_version = "TypeVersion",
    };
};
