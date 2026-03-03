const HookFailureMode = @import("hook_failure_mode.zig").HookFailureMode;
const HookInvocationPoint = @import("hook_invocation_point.zig").HookInvocationPoint;
const ChangeSetHookTargetDetails = @import("change_set_hook_target_details.zig").ChangeSetHookTargetDetails;

/// Specifies the resource, the Hook, and the Hook version to be invoked.
pub const ChangeSetHook = struct {
    /// Specify the Hook failure mode for non-compliant resources in the followings
    /// ways.
    ///
    /// * `FAIL` Stops provisioning resources.
    ///
    /// * `WARN` Allows provisioning to continue with a warning message.
    failure_mode: ?HookFailureMode = null,

    /// The specific point in the provisioning process where the Hook is invoked.
    invocation_point: ?HookInvocationPoint = null,

    /// Specifies details about the target that the Hook will run against.
    target_details: ?ChangeSetHookTargetDetails = null,

    /// The version ID of the type configuration.
    type_configuration_version_id: ?[]const u8 = null,

    /// The unique name for your Hook. Specifies a three-part namespace for your
    /// Hook, with a
    /// recommended pattern of `Organization::Service::Hook`.
    ///
    /// The following organization namespaces are reserved and can't be used in your
    /// Hook type
    /// names:
    ///
    /// * `Alexa`
    ///
    /// * `AMZN`
    ///
    /// * `Amazon`
    ///
    /// * `ASK`
    ///
    /// * `AWS`
    ///
    /// * `Custom`
    ///
    /// * `Dev`
    type_name: ?[]const u8 = null,

    /// The version ID of the type specified.
    type_version_id: ?[]const u8 = null,
};
