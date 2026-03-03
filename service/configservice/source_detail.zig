const EventSource = @import("event_source.zig").EventSource;
const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;
const MessageType = @import("message_type.zig").MessageType;

/// Provides the source and the message types that trigger Config to evaluate
/// your Amazon Web Services resources against a rule. It also
/// provides the frequency with which you want Config to run
/// evaluations for the rule if the trigger type is periodic. You can
/// specify the parameter values for `SourceDetail` only for
/// custom rules.
pub const SourceDetail = struct {
    /// The source of the event, such as an Amazon Web Services service, that
    /// triggers
    /// Config to evaluate your Amazon Web Services resources.
    event_source: ?EventSource = null,

    /// The frequency at which you want Config to run evaluations
    /// for a custom rule with a periodic trigger. If you specify a value
    /// for `MaximumExecutionFrequency`, then
    /// `MessageType` must use the
    /// `ScheduledNotification` value.
    ///
    /// By default, rules with a periodic trigger are evaluated
    /// every 24 hours. To change the frequency, specify a valid value
    /// for the `MaximumExecutionFrequency`
    /// parameter.
    ///
    /// Based on the valid value you choose, Config runs
    /// evaluations once for each valid value. For example, if you
    /// choose `Three_Hours`, Config runs evaluations
    /// once every three hours. In this case, `Three_Hours`
    /// is the frequency of this rule.
    maximum_execution_frequency: ?MaximumExecutionFrequency = null,

    /// The type of notification that triggers Config to run an
    /// evaluation for a rule. You can specify the following notification
    /// types:
    ///
    /// * `ConfigurationItemChangeNotification` - Triggers
    /// an evaluation when Config delivers a configuration item
    /// as a result of a resource change.
    ///
    /// * `OversizedConfigurationItemChangeNotification`
    /// - Triggers an evaluation when Config delivers an
    /// oversized configuration item. Config may generate this
    /// notification type when a resource changes and the
    /// notification exceeds the maximum size allowed by Amazon
    /// SNS.
    ///
    /// * `ScheduledNotification` - Triggers a
    /// periodic evaluation at the frequency specified for
    /// `MaximumExecutionFrequency`.
    ///
    /// * `ConfigurationSnapshotDeliveryCompleted` -
    /// Triggers a periodic evaluation when Config delivers a
    /// configuration snapshot.
    ///
    /// If you want your custom rule to be triggered by configuration
    /// changes, specify two SourceDetail objects, one for
    /// `ConfigurationItemChangeNotification` and one for
    /// `OversizedConfigurationItemChangeNotification`.
    message_type: ?MessageType = null,

    pub const json_field_names = .{
        .event_source = "EventSource",
        .maximum_execution_frequency = "MaximumExecutionFrequency",
        .message_type = "MessageType",
    };
};
