const aws = @import("aws");

/// Contains information about a component that is a candidate to deploy to a
/// Greengrass core
/// device.
pub const ComponentCandidate = struct {
    /// The name of the component.
    component_name: ?[]const u8,

    /// The version of the component.
    component_version: ?[]const u8,

    /// The version requirements for the component's dependencies. Greengrass core
    /// devices get the
    /// version requirements from component recipes.
    ///
    /// IoT Greengrass V2 uses semantic version constraints. For more information,
    /// see [Semantic Versioning](https://semver.org/).
    version_requirements: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_version = "componentVersion",
        .version_requirements = "versionRequirements",
    };
};
