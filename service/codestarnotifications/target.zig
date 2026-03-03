/// Information about the Amazon Q Developer in chat applications topics or
/// Amazon Q Developer in chat applications clients associated with a
/// notification rule.
pub const Target = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Developer in chat
    /// applications topic or Amazon Q Developer in chat applications client.
    target_address: ?[]const u8 = null,

    /// The target type. Can be an Amazon Q Developer in chat applications topic or
    /// Amazon Q Developer in chat applications client.
    ///
    /// * Amazon Q Developer in chat applications topics are specified as `SNS`.
    ///
    /// * Amazon Q Developer in chat applications clients are specified as
    ///   `AWSChatbotSlack`.
    target_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .target_address = "TargetAddress",
        .target_type = "TargetType",
    };
};
