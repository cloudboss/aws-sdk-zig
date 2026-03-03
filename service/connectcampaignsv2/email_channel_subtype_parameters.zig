const aws = @import("aws");

/// Parameters for the Email Channel Subtype
pub const EmailChannelSubtypeParameters = struct {
    connect_source_email_address: ?[]const u8 = null,

    destination_email_address: []const u8,

    template_arn: ?[]const u8 = null,

    template_parameters: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .connect_source_email_address = "connectSourceEmailAddress",
        .destination_email_address = "destinationEmailAddress",
        .template_arn = "templateArn",
        .template_parameters = "templateParameters",
    };
};
