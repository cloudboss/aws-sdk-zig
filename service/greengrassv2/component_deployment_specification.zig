const ComponentConfigurationUpdate = @import("component_configuration_update.zig").ComponentConfigurationUpdate;
const ComponentRunWith = @import("component_run_with.zig").ComponentRunWith;

/// Contains information about a component to deploy.
pub const ComponentDeploymentSpecification = struct {
    /// The version of the component.
    component_version: []const u8,

    /// The configuration updates to deploy for the component. You can define
    /// *reset* updates and *merge* updates. A reset updates
    /// the keys that you specify to the default configuration for the component. A
    /// merge updates the
    /// core device's component configuration with the keys and values that you
    /// specify. The IoT Greengrass Core
    /// software applies reset updates before it applies merge updates. For more
    /// information, see
    /// [Update component
    /// configurations](https://docs.aws.amazon.com/greengrass/v2/developerguide/update-component-configurations.html) in the *IoT Greengrass V2 Developer Guide*.
    configuration_update: ?ComponentConfigurationUpdate,

    /// The system user and group that the IoT Greengrass Core software uses to run
    /// component processes on the
    /// core device. If you omit this parameter, the IoT Greengrass Core software
    /// uses the system user and group
    /// that you configure for the core device. For more information, see [Configure
    /// the user and group that run
    /// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-user) in the *IoT Greengrass V2 Developer
    /// Guide*.
    run_with: ?ComponentRunWith,

    pub const json_field_names = .{
        .component_version = "componentVersion",
        .configuration_update = "configurationUpdate",
        .run_with = "runWith",
    };
};
