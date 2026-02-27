/// Status information for your Config Managed rules and Config Custom Policy
/// rules. The
/// status includes information such as the last time the rule ran, the
/// last time it failed, and the related error for the last
/// failure.
///
/// This operation does not return status information about Config Custom Lambda
/// rules.
pub const ConfigRuleEvaluationStatus = struct {
    /// The Amazon Resource Name (ARN) of the Config
    /// rule.
    config_rule_arn: ?[]const u8,

    /// The ID of the Config rule.
    config_rule_id: ?[]const u8,

    /// The name of the Config rule.
    config_rule_name: ?[]const u8,

    /// The time that you first activated the Config
    /// rule.
    first_activated_time: ?i64,

    /// Indicates whether Config has evaluated your resources
    /// against the rule at least once.
    ///
    /// * `true` - Config has evaluated your Amazon Web Services
    /// resources against the rule at least once.
    ///
    /// * `false` - Config has not finished evaluating your Amazon Web Services
    ///   resources against the
    /// rule
    /// at least once.
    first_evaluation_started: bool = false,

    /// The time that you last turned off the Config rule.
    last_deactivated_time: ?i64,

    /// The status of the last attempted delivery of a debug log for your Config
    /// Custom Policy rules. Either `Successful` or `Failed`.
    last_debug_log_delivery_status: ?[]const u8,

    /// The reason Config was not able to deliver a debug log. This is for the last
    /// failed attempt to retrieve a debug log for your Config Custom Policy rules.
    last_debug_log_delivery_status_reason: ?[]const u8,

    /// The time Config last attempted to deliver a debug log for your Config Custom
    /// Policy rules.
    last_debug_log_delivery_time: ?i64,

    /// The error code that Config returned when the rule last
    /// failed.
    last_error_code: ?[]const u8,

    /// The error message that Config returned when the rule last
    /// failed.
    last_error_message: ?[]const u8,

    /// The time that Config last failed to evaluate your Amazon Web Services
    /// resources against the rule.
    last_failed_evaluation_time: ?i64,

    /// The time that Config last failed to invoke the Config
    /// rule to evaluate your Amazon Web Services resources.
    last_failed_invocation_time: ?i64,

    /// The time that Config last successfully evaluated your Amazon Web Services
    /// resources against the rule.
    last_successful_evaluation_time: ?i64,

    /// The time that Config last successfully invoked the Config rule to evaluate
    /// your Amazon Web Services resources.
    last_successful_invocation_time: ?i64,

    pub const json_field_names = .{
        .config_rule_arn = "ConfigRuleArn",
        .config_rule_id = "ConfigRuleId",
        .config_rule_name = "ConfigRuleName",
        .first_activated_time = "FirstActivatedTime",
        .first_evaluation_started = "FirstEvaluationStarted",
        .last_deactivated_time = "LastDeactivatedTime",
        .last_debug_log_delivery_status = "LastDebugLogDeliveryStatus",
        .last_debug_log_delivery_status_reason = "LastDebugLogDeliveryStatusReason",
        .last_debug_log_delivery_time = "LastDebugLogDeliveryTime",
        .last_error_code = "LastErrorCode",
        .last_error_message = "LastErrorMessage",
        .last_failed_evaluation_time = "LastFailedEvaluationTime",
        .last_failed_invocation_time = "LastFailedInvocationTime",
        .last_successful_evaluation_time = "LastSuccessfulEvaluationTime",
        .last_successful_invocation_time = "LastSuccessfulInvocationTime",
    };
};
