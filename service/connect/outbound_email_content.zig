const OutboundMessageSourceType = @import("outbound_message_source_type.zig").OutboundMessageSourceType;
const OutboundRawMessage = @import("outbound_raw_message.zig").OutboundRawMessage;
const TemplatedMessageConfig = @import("templated_message_config.zig").TemplatedMessageConfig;

/// Information about email body content.
pub const OutboundEmailContent = struct {
    /// The message source type, that is, `RAW` or `TEMPLATE`.
    message_source_type: OutboundMessageSourceType,

    /// The raw email body content.
    raw_message: ?OutboundRawMessage,

    /// Information about template message configuration.
    templated_message_config: ?TemplatedMessageConfig,

    pub const json_field_names = .{
        .message_source_type = "MessageSourceType",
        .raw_message = "RawMessage",
        .templated_message_config = "TemplatedMessageConfig",
    };
};
