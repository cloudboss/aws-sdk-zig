/// Contains information about a deployment's update to a component's
/// configuration on
/// Greengrass core devices. For more information, see [Update component
/// configurations](https://docs.aws.amazon.com/greengrass/v2/developerguide/update-component-configurations.html) in the *IoT Greengrass V2 Developer Guide*.
pub const ComponentConfigurationUpdate = struct {
    /// A serialized JSON string that contains the configuration object to merge to
    /// target
    /// devices. The core device merges this configuration with the component's
    /// existing
    /// configuration. If this is the first time a component deploys on a device,
    /// the core device
    /// merges this configuration with the component's default configuration. This
    /// means that the core
    /// device keeps it's existing configuration for keys and values that you don't
    /// specify in this
    /// object. For more information, see [Merge configuration
    /// updates](https://docs.aws.amazon.com/greengrass/v2/developerguide/update-component-configurations.html#merge-configuration-update) in the *IoT Greengrass V2 Developer
    /// Guide*.
    merge: ?[]const u8,

    /// The list of configuration nodes to reset to default values on target
    /// devices. Use JSON
    /// pointers to specify each node to reset. JSON pointers start with a forward
    /// slash
    /// (`/`) and use forward slashes to separate the key for each level in the
    /// object.
    /// For more information, see the [JSON pointer
    /// specification](https://tools.ietf.org/html/rfc6901) and [Reset configuration
    /// updates](https://docs.aws.amazon.com/greengrass/v2/developerguide/update-component-configurations.html#reset-configuration-update) in the *IoT Greengrass V2 Developer
    /// Guide*.
    reset: ?[]const []const u8,

    pub const json_field_names = .{
        .merge = "merge",
        .reset = "reset",
    };
};
