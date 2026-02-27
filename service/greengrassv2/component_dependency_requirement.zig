const ComponentDependencyType = @import("component_dependency_type.zig").ComponentDependencyType;

/// Contains information about a component dependency for a Lambda function
/// component.
pub const ComponentDependencyRequirement = struct {
    /// The type of this dependency. Choose from the following options:
    ///
    /// * `SOFT` – The component doesn't restart if the dependency changes
    /// state.
    ///
    /// * `HARD` – The component restarts if the dependency changes
    /// state.
    ///
    /// Default: `HARD`
    dependency_type: ?ComponentDependencyType,

    /// The component version requirement for the component dependency.
    ///
    /// IoT Greengrass V2 uses semantic version constraints. For more information,
    /// see [Semantic Versioning](https://semver.org/).
    version_requirement: ?[]const u8,

    pub const json_field_names = .{
        .dependency_type = "dependencyType",
        .version_requirement = "versionRequirement",
    };
};
