const std = @import("std");

pub const RequiredSignUpAttributesElement = enum {
    address,
    birthdate,
    email,
    family_name,
    gender,
    given_name,
    locale,
    middle_name,
    name,
    nickname,
    phone_number,
    picture,
    preferred_username,
    profile,
    updated_at,
    website,
    zone_info,

    pub const json_field_names = .{
        .address = "ADDRESS",
        .birthdate = "BIRTHDATE",
        .email = "EMAIL",
        .family_name = "FAMILY_NAME",
        .gender = "GENDER",
        .given_name = "GIVEN_NAME",
        .locale = "LOCALE",
        .middle_name = "MIDDLE_NAME",
        .name = "NAME",
        .nickname = "NICKNAME",
        .phone_number = "PHONE_NUMBER",
        .picture = "PICTURE",
        .preferred_username = "PREFERRED_USERNAME",
        .profile = "PROFILE",
        .updated_at = "UPDATED_AT",
        .website = "WEBSITE",
        .zone_info = "ZONE_INFO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .address => "ADDRESS",
            .birthdate => "BIRTHDATE",
            .email => "EMAIL",
            .family_name => "FAMILY_NAME",
            .gender => "GENDER",
            .given_name => "GIVEN_NAME",
            .locale => "LOCALE",
            .middle_name => "MIDDLE_NAME",
            .name => "NAME",
            .nickname => "NICKNAME",
            .phone_number => "PHONE_NUMBER",
            .picture => "PICTURE",
            .preferred_username => "PREFERRED_USERNAME",
            .profile => "PROFILE",
            .updated_at => "UPDATED_AT",
            .website => "WEBSITE",
            .zone_info => "ZONE_INFO",
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
