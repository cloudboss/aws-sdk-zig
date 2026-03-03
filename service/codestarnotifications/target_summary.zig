const TargetStatus = @import("target_status.zig").TargetStatus;

/// Information about the targets specified for a notification rule.
pub const TargetSummary = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Developer in chat
    /// applications topic or Amazon Q Developer in chat applications client.
    target_address: ?[]const u8 = null,

    /// The status of the target.
    target_status: ?TargetStatus = null,

    /// The type of the target (for example, `SNS`).
    ///
    /// * Amazon Q Developer in chat applications topics are specified as `SNS`.
    ///
    /// * Amazon Q Developer in chat applications clients are specified as
    ///   `AWSChatbotSlack`.
    target_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .target_address = "TargetAddress",
        .target_status = "TargetStatus",
        .target_type = "TargetType",
    };
};
