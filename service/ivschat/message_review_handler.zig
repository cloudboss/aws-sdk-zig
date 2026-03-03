const FallbackResult = @import("fallback_result.zig").FallbackResult;

/// Configuration information for optional message review.
pub const MessageReviewHandler = struct {
    /// Specifies the fallback behavior (whether the message is allowed or denied)
    /// if the handler
    /// does not return a valid response, encounters an error, or times out. (For
    /// the timeout period,
    /// see [ Service
    /// Quotas](https://docs.aws.amazon.com/ivs/latest/userguide/service-quotas.html).) If allowed, the message is delivered with returned content to all users
    /// connected to the room. If denied, the message is not delivered to any user.
    /// Default:
    /// `ALLOW`.
    fallback_result: ?FallbackResult = null,

    /// Identifier of the message review handler. Currently this must be an ARN of a
    /// lambda
    /// function.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .fallback_result = "fallbackResult",
        .uri = "uri",
    };
};
