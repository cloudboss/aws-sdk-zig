const aws = @import("aws");

/// A configuration specification to be used when provisioning an application. A
/// configuration consists of a classification, properties, and optional nested
/// configurations. A classification refers to an application-specific
/// configuration file. Properties are the settings you want to change in that
/// file.
pub const Configuration = struct {
    /// The classification within a configuration.
    classification: []const u8,

    /// A list of additional configurations to apply within a configuration object.
    configurations: ?[]const Configuration = null,

    /// A set of properties specified within a configuration classification.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .classification = "classification",
        .configurations = "configurations",
        .properties = "properties",
    };
};
