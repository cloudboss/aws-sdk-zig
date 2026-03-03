const InboundMessageSourceType = @import("inbound_message_source_type.zig").InboundMessageSourceType;
const InboundRawMessage = @import("inbound_raw_message.zig").InboundRawMessage;

/// Information about email body content.
pub const InboundEmailContent = struct {
    /// The message source type, that is, `RAW`.
    message_source_type: InboundMessageSourceType,

    /// The raw email body content.
    raw_message: ?InboundRawMessage = null,

    pub const json_field_names = .{
        .message_source_type = "MessageSourceType",
        .raw_message = "RawMessage",
    };
};
