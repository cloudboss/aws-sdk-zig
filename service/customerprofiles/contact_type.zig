const std = @import("std");

pub const ContactType = enum {
    phone_number,
    mobile_phone_number,
    home_phone_number,
    business_phone_number,
    email_address,
    personal_email_address,
    business_email_address,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
        .mobile_phone_number = "MobilePhoneNumber",
        .home_phone_number = "HomePhoneNumber",
        .business_phone_number = "BusinessPhoneNumber",
        .email_address = "EmailAddress",
        .personal_email_address = "PersonalEmailAddress",
        .business_email_address = "BusinessEmailAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .phone_number => "PhoneNumber",
            .mobile_phone_number => "MobilePhoneNumber",
            .home_phone_number => "HomePhoneNumber",
            .business_phone_number => "BusinessPhoneNumber",
            .email_address => "EmailAddress",
            .personal_email_address => "PersonalEmailAddress",
            .business_email_address => "BusinessEmailAddress",
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
