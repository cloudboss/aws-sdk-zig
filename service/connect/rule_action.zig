const ActionType = @import("action_type.zig").ActionType;
const AssignContactCategoryActionDefinition = @import("assign_contact_category_action_definition.zig").AssignContactCategoryActionDefinition;
const AssignSlaActionDefinition = @import("assign_sla_action_definition.zig").AssignSlaActionDefinition;
const CreateCaseActionDefinition = @import("create_case_action_definition.zig").CreateCaseActionDefinition;
const EndAssociatedTasksActionDefinition = @import("end_associated_tasks_action_definition.zig").EndAssociatedTasksActionDefinition;
const EventBridgeActionDefinition = @import("event_bridge_action_definition.zig").EventBridgeActionDefinition;
const SendNotificationActionDefinition = @import("send_notification_action_definition.zig").SendNotificationActionDefinition;
const SubmitAutoEvaluationActionDefinition = @import("submit_auto_evaluation_action_definition.zig").SubmitAutoEvaluationActionDefinition;
const TaskActionDefinition = @import("task_action_definition.zig").TaskActionDefinition;
const UpdateCaseActionDefinition = @import("update_case_action_definition.zig").UpdateCaseActionDefinition;

/// Information about the action to be performed when a rule is triggered.
pub const RuleAction = struct {
    /// The type of action that creates a rule.
    action_type: ActionType,

    /// Information about the contact category action.
    ///
    /// Supported only for `TriggerEventSource` values:
    /// `OnPostCallAnalysisAvailable` |
    /// `OnRealTimeCallAnalysisAvailable` | `OnRealTimeChatAnalysisAvailable` |
    /// `OnPostChatAnalysisAvailable` | `OnZendeskTicketCreate` |
    /// `OnZendeskTicketStatusUpdate` | `OnSalesforceCaseCreate`
    assign_contact_category_action: ?AssignContactCategoryActionDefinition,

    /// Information about the assign SLA action.
    assign_sla_action: ?AssignSlaActionDefinition,

    /// Information about the create case action.
    ///
    /// Supported only for `TriggerEventSource` values:
    /// `OnPostCallAnalysisAvailable` |
    /// `OnPostChatAnalysisAvailable`.
    create_case_action: ?CreateCaseActionDefinition,

    /// Information about the end associated tasks action.
    ///
    /// Supported only for `TriggerEventSource` values: `OnCaseUpdate`.
    end_associated_tasks_action: ?EndAssociatedTasksActionDefinition,

    /// Information about the EventBridge action.
    ///
    /// Supported only for `TriggerEventSource` values:
    /// `OnPostCallAnalysisAvailable` |
    /// `OnRealTimeCallAnalysisAvailable` | `OnRealTimeChatAnalysisAvailable` |
    /// `OnPostChatAnalysisAvailable` | `OnContactEvaluationSubmit` |
    /// `OnMetricDataUpdate`
    event_bridge_action: ?EventBridgeActionDefinition,

    /// Information about the send notification action.
    ///
    /// Supported only for `TriggerEventSource` values:
    /// `OnPostCallAnalysisAvailable` |
    /// `OnRealTimeCallAnalysisAvailable` | `OnRealTimeChatAnalysisAvailable` |
    /// `OnPostChatAnalysisAvailable` | `OnContactEvaluationSubmit` |
    /// `OnMetricDataUpdate`
    send_notification_action: ?SendNotificationActionDefinition,

    /// Information about the submit automated evaluation action.
    submit_auto_evaluation_action: ?SubmitAutoEvaluationActionDefinition,

    /// Information about the task action. This field is required if
    /// `TriggerEventSource` is one of the
    /// following values: `OnZendeskTicketCreate` | `OnZendeskTicketStatusUpdate` |
    /// `OnSalesforceCaseCreate`
    task_action: ?TaskActionDefinition,

    /// Information about the update case action.
    ///
    /// Supported only for `TriggerEventSource` values: `OnCaseCreate` |
    /// `OnCaseUpdate`.
    update_case_action: ?UpdateCaseActionDefinition,

    pub const json_field_names = .{
        .action_type = "ActionType",
        .assign_contact_category_action = "AssignContactCategoryAction",
        .assign_sla_action = "AssignSlaAction",
        .create_case_action = "CreateCaseAction",
        .end_associated_tasks_action = "EndAssociatedTasksAction",
        .event_bridge_action = "EventBridgeAction",
        .send_notification_action = "SendNotificationAction",
        .submit_auto_evaluation_action = "SubmitAutoEvaluationAction",
        .task_action = "TaskAction",
        .update_case_action = "UpdateCaseAction",
    };
};
