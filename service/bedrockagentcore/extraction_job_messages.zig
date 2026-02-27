const MessageMetadata = @import("message_metadata.zig").MessageMetadata;

/// The list of messages that compose this extraction job.
pub const ExtractionJobMessages = union(enum) {
    /// The list of messages that compose this extraction job.
    messages_list: ?[]const MessageMetadata,

    pub const json_field_names = .{
        .messages_list = "messagesList",
    };
};
