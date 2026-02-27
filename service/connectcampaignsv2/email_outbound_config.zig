/// Default Email Outbound config
pub const EmailOutboundConfig = struct {
    connect_source_email_address: []const u8,

    source_email_address_display_name: ?[]const u8,

    wisdom_template_arn: []const u8,

    pub const json_field_names = .{
        .connect_source_email_address = "connectSourceEmailAddress",
        .source_email_address_display_name = "sourceEmailAddressDisplayName",
        .wisdom_template_arn = "wisdomTemplateArn",
    };
};
