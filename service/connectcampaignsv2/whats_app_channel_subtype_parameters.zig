const aws = @import("aws");

/// Parameters for the WhatsApp Channel Subtype
pub const WhatsAppChannelSubtypeParameters = struct {
    connect_source_phone_number_arn: ?[]const u8,

    destination_phone_number: []const u8,

    template_arn: ?[]const u8,

    template_parameters: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .connect_source_phone_number_arn = "connectSourcePhoneNumberArn",
        .destination_phone_number = "destinationPhoneNumber",
        .template_arn = "templateArn",
        .template_parameters = "templateParameters",
    };
};
