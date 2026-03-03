const std = @import("std");

pub const ResourceType = enum {
    account,
    phone_number,
    sender_id,
    pool,
    configuration_set,
    opt_out_list,
    event_destination,
    keyword,
    opted_out_number,
    registration,
    registration_attachment,
    verified_destination_number,
    protect_configuration,
    message_template,
    policy,
    message,

    pub const json_field_names = .{
        .account = "account",
        .phone_number = "phone-number",
        .sender_id = "sender-id",
        .pool = "pool",
        .configuration_set = "configuration-set",
        .opt_out_list = "opt-out-list",
        .event_destination = "event-destination",
        .keyword = "keyword",
        .opted_out_number = "opted-out-number",
        .registration = "registration",
        .registration_attachment = "registration-attachment",
        .verified_destination_number = "verified-destination-number",
        .protect_configuration = "protect-configuration",
        .message_template = "message-template",
        .policy = "policy",
        .message = "message",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "account",
            .phone_number => "phone-number",
            .sender_id => "sender-id",
            .pool => "pool",
            .configuration_set => "configuration-set",
            .opt_out_list => "opt-out-list",
            .event_destination => "event-destination",
            .keyword => "keyword",
            .opted_out_number => "opted-out-number",
            .registration => "registration",
            .registration_attachment => "registration-attachment",
            .verified_destination_number => "verified-destination-number",
            .protect_configuration => "protect-configuration",
            .message_template => "message-template",
            .policy => "policy",
            .message => "message",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
