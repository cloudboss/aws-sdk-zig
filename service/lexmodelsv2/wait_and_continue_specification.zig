const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const StillWaitingResponseSpecification = @import("still_waiting_response_specification.zig").StillWaitingResponseSpecification;

/// Specifies the prompts that Amazon Lex uses while a bot is waiting for
/// customer input.
pub const WaitAndContinueSpecification = struct {
    /// Specifies whether the bot will wait for a user to respond. When this
    /// field is false, wait and continue responses for a slot aren't used. If
    /// the `active` field isn't specified, the default is
    /// true.
    active: ?bool = null,

    /// The response that Amazon Lex sends to indicate that the bot is ready to
    /// continue the conversation.
    continue_response: ResponseSpecification,

    /// A response that Amazon Lex sends periodically to the user to indicate
    /// that the bot is still waiting for input from the user.
    still_waiting_response: ?StillWaitingResponseSpecification = null,

    /// The response that Amazon Lex sends to indicate that the bot is waiting
    /// for the conversation to continue.
    waiting_response: ResponseSpecification,

    pub const json_field_names = .{
        .active = "active",
        .continue_response = "continueResponse",
        .still_waiting_response = "stillWaitingResponse",
        .waiting_response = "waitingResponse",
    };
};
