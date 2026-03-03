const AcknowledgeActionConfiguration = @import("acknowledge_action_configuration.zig").AcknowledgeActionConfiguration;
const CustomerActionName = @import("customer_action_name.zig").CustomerActionName;
const DisableActionConfiguration = @import("disable_action_configuration.zig").DisableActionConfiguration;
const EnableActionConfiguration = @import("enable_action_configuration.zig").EnableActionConfiguration;
const ResetActionConfiguration = @import("reset_action_configuration.zig").ResetActionConfiguration;
const SnoozeActionConfiguration = @import("snooze_action_configuration.zig").SnoozeActionConfiguration;

/// Contains information about the action that you can take to respond to the
/// alarm.
pub const CustomerAction = struct {
    /// Contains the configuration information of an acknowledge action.
    acknowledge_action_configuration: ?AcknowledgeActionConfiguration = null,

    /// The name of the action. The action name can be one of the following values:
    ///
    /// * `SNOOZE` - When you snooze the alarm, the alarm state changes to
    ///   `SNOOZE_DISABLED`.
    ///
    /// * `ENABLE` - When you enable the alarm, the alarm state changes to `NORMAL`.
    ///
    /// * `DISABLE` - When you disable the alarm, the alarm state changes to
    ///   `DISABLED`.
    ///
    /// * `ACKNOWLEDGE` - When you acknowledge the alarm, the alarm state changes to
    ///   `ACKNOWLEDGED`.
    ///
    /// * `RESET` - When you reset the alarm, the alarm state changes to `NORMAL`.
    ///
    /// For more information, see the
    /// [AlarmState](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_AlarmState.html) API.
    action_name: ?CustomerActionName = null,

    /// Contains the configuration information of a disable action.
    disable_action_configuration: ?DisableActionConfiguration = null,

    /// Contains the configuration information of an enable action.
    enable_action_configuration: ?EnableActionConfiguration = null,

    /// Contains the configuration information of a reset action.
    reset_action_configuration: ?ResetActionConfiguration = null,

    /// Contains the configuration information of a snooze action.
    snooze_action_configuration: ?SnoozeActionConfiguration = null,

    pub const json_field_names = .{
        .acknowledge_action_configuration = "acknowledgeActionConfiguration",
        .action_name = "actionName",
        .disable_action_configuration = "disableActionConfiguration",
        .enable_action_configuration = "enableActionConfiguration",
        .reset_action_configuration = "resetActionConfiguration",
        .snooze_action_configuration = "snoozeActionConfiguration",
    };
};
