const InvocationResultMember = @import("invocation_result_member.zig").InvocationResultMember;

/// An action invocation result.
pub const ReturnControlResults = struct {
    /// The action's invocation ID.
    invocation_id: ?[]const u8 = null,

    /// The action invocation result.
    return_control_invocation_results: ?[]const InvocationResultMember = null,

    pub const json_field_names = .{
        .invocation_id = "invocationId",
        .return_control_invocation_results = "returnControlInvocationResults",
    };
};
