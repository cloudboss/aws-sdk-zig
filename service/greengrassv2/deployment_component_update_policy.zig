const DeploymentComponentUpdatePolicyAction = @import("deployment_component_update_policy_action.zig").DeploymentComponentUpdatePolicyAction;

/// Contains information about a deployment's policy that defines when
/// components are safe to
/// update.
///
/// Each component on a device can report whether or not it's ready to update.
/// After a
/// component and its dependencies are ready, they can apply the update in the
/// deployment. You can
/// configure whether or not the deployment notifies components of an update and
/// waits for a
/// response. You specify the amount of time each component has to respond to
/// the update
/// notification.
pub const DeploymentComponentUpdatePolicy = struct {
    /// Whether or not to notify components and wait for components to become safe
    /// to update.
    /// Choose from the following options:
    ///
    /// * `NOTIFY_COMPONENTS` – The deployment notifies each component before
    /// it stops and updates that component. Components can use the
    /// [SubscribeToComponentUpdates](https://docs.aws.amazon.com/greengrass/v2/developerguide/interprocess-communication.html#ipc-operation-subscribetocomponentupdates) IPC operation to receive these notifications. Then,
    /// components can respond with the
    /// [DeferComponentUpdate](https://docs.aws.amazon.com/greengrass/v2/developerguide/interprocess-communication.html#ipc-operation-defercomponentupdate) IPC operation. For more information, see [Create
    /// deployments](https://docs.aws.amazon.com/greengrass/v2/developerguide/create-deployments.html) in the *IoT Greengrass V2 Developer Guide*.
    ///
    /// * `SKIP_NOTIFY_COMPONENTS` – The deployment doesn't notify components
    /// or wait for them to be safe to update.
    ///
    /// Default: `NOTIFY_COMPONENTS`
    action: ?DeploymentComponentUpdatePolicyAction = null,

    /// The amount of time in seconds that each component on a device has to report
    /// that it's safe
    /// to update. If the component waits for longer than this timeout, then the
    /// deployment proceeds
    /// on the device.
    ///
    /// Default: `60`
    timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .action = "action",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
