const ApprovalAction = @import("approval_action.zig").ApprovalAction;

/// Context object for additional message metadata
pub const SendMessageContext = struct {
    /// An approval decision supplied when resuming a paused agent execution. When
    /// an agent execution pauses to request approval for an elevated action,
    /// SendMessage streams an approval request carrying interrupt identifiers. To
    /// resume the paused execution, call SendMessage again with
    /// `userActionResponse` set to `"APPROVAL_ACTION"` and this member populated
    /// with those identifiers and the decision (APPROVED or REJECTED). Optional;
    /// omit it for messages that are not resuming an approval.
    approval_action: ?ApprovalAction = null,

    /// The current page or view the user is on
    current_page: ?[]const u8 = null,

    /// The ID of the last message in the conversation
    last_message: ?[]const u8 = null,

    /// Response to a UI prompt (not a text conversation message). Set this to the
    /// sentinel value `"APPROVAL_ACTION"` when the request is resuming a paused
    /// execution after an approval decision; in that case the structured decision
    /// is provided on the sibling `approvalAction` member. Preserved as a String
    /// for backward compatibility: clients that predate the typed approval field
    /// may still encode UI-prompt responses as JSON in this field.
    user_action_response: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_action = "approvalAction",
        .current_page = "currentPage",
        .last_message = "lastMessage",
        .user_action_response = "userActionResponse",
    };
};
