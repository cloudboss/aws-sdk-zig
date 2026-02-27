const aws = @import("aws");

const MessageGroup = @import("message_group.zig").MessageGroup;
const MessageSelectionStrategy = @import("message_selection_strategy.zig").MessageSelectionStrategy;
const PromptAttemptSpecification = @import("prompt_attempt_specification.zig").PromptAttemptSpecification;

/// Specifies a list of message groups that Amazon Lex sends to a user to
/// elicit a response.
pub const PromptSpecification = struct {
    /// Indicates whether the user can interrupt a speech prompt from the
    /// bot.
    allow_interrupt: ?bool,

    /// The maximum number of times the bot tries to elicit a response from
    /// the user using this prompt.
    max_retries: i32,

    /// A collection of messages that Amazon Lex can send to the user. Amazon Lex
    /// chooses the actual message to send at runtime.
    message_groups: []const MessageGroup,

    /// Indicates how a message is selected from a message group among retries.
    message_selection_strategy: ?MessageSelectionStrategy,

    /// Specifies the advanced settings on each attempt of the prompt.
    prompt_attempts_specification: ?[]const aws.map.MapEntry(PromptAttemptSpecification),

    pub const json_field_names = .{
        .allow_interrupt = "allowInterrupt",
        .max_retries = "maxRetries",
        .message_groups = "messageGroups",
        .message_selection_strategy = "messageSelectionStrategy",
        .prompt_attempts_specification = "promptAttemptsSpecification",
    };
};
