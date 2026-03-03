/// The content of the message template that applies to the WHATSAPP channel
/// subtype.
pub const WhatsAppMessageTemplateContent = struct {
    /// The data.
    data: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
    };
};
