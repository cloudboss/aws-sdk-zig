const ActionExecution = @import("action_execution.zig").ActionExecution;
const ActionReview = @import("action_review.zig").ActionReview;
const AttachmentOutput = @import("attachment_output.zig").AttachmentOutput;
const SourceAttribution = @import("source_attribution.zig").SourceAttribution;
const MessageType = @import("message_type.zig").MessageType;

/// A message in an Amazon Q Business web experience.
pub const Message = struct {
    action_execution: ?ActionExecution = null,

    action_review: ?ActionReview = null,

    /// A file directly uploaded into an Amazon Q Business web experience chat.
    attachments: ?[]const AttachmentOutput = null,

    /// The content of the Amazon Q Business web experience message.
    body: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business web experience message.
    message_id: ?[]const u8 = null,

    /// The source documents used to generate Amazon Q Business web experience
    /// message.
    source_attribution: ?[]const SourceAttribution = null,

    /// The timestamp of the first Amazon Q Business web experience message.
    time: ?i64 = null,

    /// The type of Amazon Q Business message, whether `HUMAN` or `AI` generated.
    @"type": ?MessageType = null,

    pub const json_field_names = .{
        .action_execution = "actionExecution",
        .action_review = "actionReview",
        .attachments = "attachments",
        .body = "body",
        .message_id = "messageId",
        .source_attribution = "sourceAttribution",
        .time = "time",
        .@"type" = "type",
    };
};
