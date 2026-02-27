const Attachment = @import("attachment.zig").Attachment;
const ConnectAttachmentOptions = @import("connect_attachment_options.zig").ConnectAttachmentOptions;

/// Describes a core network Connect attachment.
pub const ConnectAttachment = struct {
    /// The attachment details.
    attachment: ?Attachment,

    /// Options for connecting an attachment.
    options: ?ConnectAttachmentOptions,

    /// The ID of the transport attachment.
    transport_attachment_id: ?[]const u8,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .options = "Options",
        .transport_attachment_id = "TransportAttachmentId",
    };
};
