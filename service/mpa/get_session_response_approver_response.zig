const SessionResponse = @import("session_response.zig").SessionResponse;

/// Contains details for an approver response in an approval session.
pub const GetSessionResponseApproverResponse = struct {
    /// ID for the approver.
    approver_id: ?[]const u8 = null,

    /// ID for the identity source. The identity source manages the user
    /// authentication for approvers.
    identity_id: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the identity source. The identity source
    /// manages the user authentication for approvers.
    identity_source_arn: ?[]const u8 = null,

    /// Response to the operation request.
    response: ?SessionResponse = null,

    /// Timestamp when a approver responded to the operation request.
    response_time: ?i64 = null,

    pub const json_field_names = .{
        .approver_id = "ApproverId",
        .identity_id = "IdentityId",
        .identity_source_arn = "IdentitySourceArn",
        .response = "Response",
        .response_time = "ResponseTime",
    };
};
