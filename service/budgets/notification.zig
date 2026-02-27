const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const NotificationState = @import("notification_state.zig").NotificationState;
const NotificationType = @import("notification_type.zig").NotificationType;
const ThresholdType = @import("threshold_type.zig").ThresholdType;

/// A notification that's associated with a budget. A budget can have up to ten
/// notifications.
///
/// Each notification must have at least one subscriber. A notification can have
/// one SNS
/// subscriber and up to 10 email subscribers, for a total of 11 subscribers.
///
/// For example, if you have a budget for 200 dollars and you want to be
/// notified when you
/// go over 160 dollars, create a notification with the following parameters:
///
/// * A notificationType of `ACTUAL`
///
/// * A `thresholdType` of `PERCENTAGE`
///
/// * A `comparisonOperator` of `GREATER_THAN`
///
/// * A notification `threshold` of `80`
pub const Notification = struct {
    /// The comparison that's used for this notification.
    comparison_operator: ComparisonOperator,

    /// Specifies whether this notification is in alarm. If a budget notification is
    /// in the
    /// `ALARM` state, you passed the set threshold for the budget.
    notification_state: ?NotificationState,

    /// Specifies whether the notification is for how much you have spent
    /// (`ACTUAL`) or for how much that you're forecasted to spend
    /// (`FORECASTED`).
    notification_type: NotificationType,

    /// The threshold that's associated with a notification. Thresholds are always a
    /// percentage, and many customers find value being alerted between 50% - 200%
    /// of the
    /// budgeted amount. The maximum limit for your threshold is 1,000,000% above
    /// the budgeted
    /// amount.
    threshold: f64 = 0,

    /// The type of threshold for a notification. For `ABSOLUTE_VALUE` thresholds,
    /// Amazon Web Services notifies you when you go over or are forecasted to go
    /// over your
    /// total cost threshold. For
    /// `PERCENTAGE` thresholds, Amazon Web Services notifies you when you go over
    /// or are forecasted to go over a certain percentage of your forecasted spend.
    /// For example,
    /// if you have a budget for 200 dollars and you have a `PERCENTAGE` threshold
    /// of
    /// 80%, Amazon Web Services notifies you when you go over 160 dollars.
    threshold_type: ?ThresholdType,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .notification_state = "NotificationState",
        .notification_type = "NotificationType",
        .threshold = "Threshold",
        .threshold_type = "ThresholdType",
    };
};
