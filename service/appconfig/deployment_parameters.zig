const aws = @import("aws");

/// The deployment parameters for an experiment run, including dynamic extension
/// parameters and tags.
pub const DeploymentParameters = struct {
    /// A map of extension parameters for the deployment.
    dynamic_extension_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The tags to assign to the deployment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .dynamic_extension_parameters = "DynamicExtensionParameters",
        .tags = "Tags",
    };
};
