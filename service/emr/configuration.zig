const aws = @import("aws");

/// Amazon EMR releases 4.x or later.
///
/// An optional configuration specification to be used when provisioning cluster
/// instances,
/// which can include configurations for applications and software bundled with
/// Amazon EMR. A configuration consists of a classification, properties, and
/// optional
/// nested configurations. A classification refers to an application-specific
/// configuration
/// file. Properties are the settings you want to change in that file. For more
/// information,
/// see [Configuring
/// Applications](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-configure-apps.html).
pub const Configuration = struct {
    /// The classification within a configuration.
    classification: ?[]const u8,

    /// A list of additional configurations to apply within a configuration object.
    configurations: ?[]const Configuration,

    /// A set of properties specified within a configuration classification.
    properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .classification = "Classification",
        .configurations = "Configurations",
        .properties = "Properties",
    };
};
