const ApprovalActionType = @import("approval_action_type.zig").ApprovalActionType;

/// An approval decision supplied when resuming a paused agent execution. When
/// an agent execution pauses to request approval for an elevated action,
/// SendMessage streams an approval request carrying interrupt identifiers. This
/// structure carries the decision back to the service — which paused tool
/// invocation is being resumed, the opaque interrupt identifier that resumes
/// it, the identifier of the approval request being resolved, optional display
/// text of the control the user chose, and the action taken (APPROVED or
/// REJECTED) — so the service can resume the paused execution. All members are
/// optional on the wire; service-side validation is applied against the
/// populated subset.
pub const ApprovalAction = struct {
    /// The action taken on the approval request — APPROVED or REJECTED.
    action: ?ApprovalActionType = null,

    /// Identifier of the approval request being resolved.
    approval_id: ?[]const u8 = null,

    /// Optional display text of the UI control the user chose (for example,
    /// "Approve Exact", "Approve Broader", or "Reject"), provided as auxiliary
    /// decision context.
    button_text: ?[]const u8 = null,

    /// An opaque resume identifier issued by the service when an agent execution
    /// pauses for approval. Provide it when resuming so the service can resume the
    /// correct paused execution.
    interrupt_id: ?[]const u8 = null,

    /// Identifier of the specific paused tool invocation that requested approval.
    /// Correlates the approval decision back to the paused invocation.
    tool_use_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .approval_id = "approvalId",
        .button_text = "buttonText",
        .interrupt_id = "interruptId",
        .tool_use_id = "toolUseId",
    };
};
