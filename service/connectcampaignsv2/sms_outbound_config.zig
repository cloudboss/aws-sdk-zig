/// Default SMS Outbound config
pub const SmsOutboundConfig = struct {
    connect_source_phone_number_arn: []const u8,

    wisdom_template_arn: []const u8,

    pub const json_field_names = .{
        .connect_source_phone_number_arn = "connectSourcePhoneNumberArn",
        .wisdom_template_arn = "wisdomTemplateArn",
    };
};
