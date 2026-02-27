const ActionThreshold = @import("action_threshold.zig").ActionThreshold;
const ActionType = @import("action_type.zig").ActionType;
const ApprovalModel = @import("approval_model.zig").ApprovalModel;
const Definition = @import("definition.zig").Definition;
const NotificationType = @import("notification_type.zig").NotificationType;
const ActionStatus = @import("action_status.zig").ActionStatus;
const Subscriber = @import("subscriber.zig").Subscriber;

/// A budget action resource.
pub const Action = struct {
    /// A system-generated universally unique identifier (UUID) for the action.
    action_id: []const u8,

    /// The trigger threshold of the action.
    action_threshold: ActionThreshold,

    /// The type of action. This defines the type of tasks that can be carried out
    /// by this
    /// action. This field also determines the format for definition.
    action_type: ActionType,

    /// This specifies if the action needs manual or automatic approval.
    approval_model: ApprovalModel,

    budget_name: []const u8,

    /// Where you specify all of the type-specific parameters.
    definition: Definition,

    /// The role passed for action execution and reversion. Roles and actions must
    /// be in the
    /// same account.
    execution_role_arn: []const u8,

    notification_type: NotificationType,

    /// The status of the action.
    status: ActionStatus,

    subscribers: []const Subscriber,

    pub const json_field_names = .{
        .action_id = "ActionId",
        .action_threshold = "ActionThreshold",
        .action_type = "ActionType",
        .approval_model = "ApprovalModel",
        .budget_name = "BudgetName",
        .definition = "Definition",
        .execution_role_arn = "ExecutionRoleArn",
        .notification_type = "NotificationType",
        .status = "Status",
        .subscribers = "Subscribers",
    };
};
