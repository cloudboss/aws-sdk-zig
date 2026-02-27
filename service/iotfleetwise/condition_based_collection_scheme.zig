const TriggerMode = @import("trigger_mode.zig").TriggerMode;

/// Information about a collection scheme that uses a simple logical expression
/// to
/// recognize what data to collect.
pub const ConditionBasedCollectionScheme = struct {
    /// Specifies the version of the conditional expression language.
    condition_language_version: ?i32,

    /// The logical expression used to recognize what data to collect. For example,
    /// `$variable.`Vehicle.OutsideAirTemperature` >= 105.0`.
    expression: []const u8,

    /// The minimum duration of time between two triggering events to collect data,
    /// in
    /// milliseconds.
    ///
    /// If a signal changes often, you might want to collect data at a slower rate.
    minimum_trigger_interval_ms: ?i64,

    /// Whether to collect data for all triggering events (`ALWAYS`). Specify
    /// (`RISING_EDGE`), or specify only when the condition first evaluates to
    /// false. For example, triggering on "AirbagDeployed"; Users aren't interested
    /// on
    /// triggering when the airbag is already exploded; they only care about the
    /// change from not
    /// deployed => deployed.
    trigger_mode: ?TriggerMode,

    pub const json_field_names = .{
        .condition_language_version = "conditionLanguageVersion",
        .expression = "expression",
        .minimum_trigger_interval_ms = "minimumTriggerIntervalMs",
        .trigger_mode = "triggerMode",
    };
};
