const std = @import("std");

pub const AccountLimitName = enum {
    phone_numbers,
    pools,
    configuration_sets,
    opt_out_lists,
    sender_ids,
    registrations,
    registration_attachments,
    verified_destination_numbers,

    pub const json_field_names = .{
        .phone_numbers = "PHONE_NUMBERS",
        .pools = "POOLS",
        .configuration_sets = "CONFIGURATION_SETS",
        .opt_out_lists = "OPT_OUT_LISTS",
        .sender_ids = "SENDER_IDS",
        .registrations = "REGISTRATIONS",
        .registration_attachments = "REGISTRATION_ATTACHMENTS",
        .verified_destination_numbers = "VERIFIED_DESTINATION_NUMBERS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .phone_numbers => "PHONE_NUMBERS",
            .pools => "POOLS",
            .configuration_sets => "CONFIGURATION_SETS",
            .opt_out_lists => "OPT_OUT_LISTS",
            .sender_ids => "SENDER_IDS",
            .registrations => "REGISTRATIONS",
            .registration_attachments => "REGISTRATION_ATTACHMENTS",
            .verified_destination_numbers => "VERIFIED_DESTINATION_NUMBERS",
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
