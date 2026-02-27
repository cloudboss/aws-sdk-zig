const NumericQuestionPropertyAutomationLabel = @import("numeric_question_property_automation_label.zig").NumericQuestionPropertyAutomationLabel;

/// Information about the property value used in automation of a numeric
/// questions. Label values are associated with
/// minimum and maximum values for the numeric question.
///
/// * Sentiment scores have a minimum value of -5 and maximum value of 5.
///
/// * Duration labels, such as `NON_TALK_TIME`, `CONTACT_DURATION`,
/// `AGENT_INTERACTION_DURATION`, `CUSTOMER_HOLD_TIME` have a minimum value of 0
/// and maximum
/// value of 63072000.
///
/// * Percentages have a minimum value of 0 and maximum value of 100.
///
/// * `NUMBER_OF_INTERRUPTIONS` has a minimum value of 0 and maximum value of
///   1000.
pub const NumericQuestionPropertyValueAutomation = struct {
    /// The property label of the automation.
    label: NumericQuestionPropertyAutomationLabel,

    pub const json_field_names = .{
        .label = "Label",
    };
};
