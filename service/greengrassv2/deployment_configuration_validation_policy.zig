/// Contains information about how long a component on a core device can
/// validate its
/// configuration updates before it times out. Components can use the
/// [SubscribeToValidateConfigurationUpdates](https://docs.aws.amazon.com/greengrass/v2/developerguide/interprocess-communication.html#ipc-operation-subscribetovalidateconfigurationupdates) IPC operation to receive notifications when
/// a deployment specifies a configuration update. Then, components can respond
/// with the
/// [SendConfigurationValidityReport](https://docs.aws.amazon.com/greengrass/v2/developerguide/interprocess-communication.html#ipc-operation-sendconfigurationvalidityreport) IPC operation. For more information, see [Create
/// deployments](https://docs.aws.amazon.com/greengrass/v2/developerguide/create-deployments.html) in the *IoT Greengrass V2 Developer Guide*.
pub const DeploymentConfigurationValidationPolicy = struct {
    /// The amount of time in seconds that a component can validate its
    /// configuration updates. If
    /// the validation time exceeds this timeout, then the deployment proceeds for
    /// the device.
    ///
    /// Default: `30`
    timeout_in_seconds: ?i32,

    pub const json_field_names = .{
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
