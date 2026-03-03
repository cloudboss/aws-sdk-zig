const std = @import("std");

pub const SchemaAttributeType = enum {
    name,
    name_first,
    name_middle,
    name_last,
    address,
    address_street1,
    address_street2,
    address_street3,
    address_city,
    address_state,
    address_country,
    address_postalcode,
    phone,
    phone_number,
    phone_countrycode,
    email_address,
    unique_id,
    date,
    string,
    provider_id,
    ipv4,
    ipv6,
    maid,

    pub const json_field_names = .{
        .name = "NAME",
        .name_first = "NAME_FIRST",
        .name_middle = "NAME_MIDDLE",
        .name_last = "NAME_LAST",
        .address = "ADDRESS",
        .address_street1 = "ADDRESS_STREET1",
        .address_street2 = "ADDRESS_STREET2",
        .address_street3 = "ADDRESS_STREET3",
        .address_city = "ADDRESS_CITY",
        .address_state = "ADDRESS_STATE",
        .address_country = "ADDRESS_COUNTRY",
        .address_postalcode = "ADDRESS_POSTALCODE",
        .phone = "PHONE",
        .phone_number = "PHONE_NUMBER",
        .phone_countrycode = "PHONE_COUNTRYCODE",
        .email_address = "EMAIL_ADDRESS",
        .unique_id = "UNIQUE_ID",
        .date = "DATE",
        .string = "STRING",
        .provider_id = "PROVIDER_ID",
        .ipv4 = "IPV4",
        .ipv6 = "IPV6",
        .maid = "MAID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .name_first => "NAME_FIRST",
            .name_middle => "NAME_MIDDLE",
            .name_last => "NAME_LAST",
            .address => "ADDRESS",
            .address_street1 => "ADDRESS_STREET1",
            .address_street2 => "ADDRESS_STREET2",
            .address_street3 => "ADDRESS_STREET3",
            .address_city => "ADDRESS_CITY",
            .address_state => "ADDRESS_STATE",
            .address_country => "ADDRESS_COUNTRY",
            .address_postalcode => "ADDRESS_POSTALCODE",
            .phone => "PHONE",
            .phone_number => "PHONE_NUMBER",
            .phone_countrycode => "PHONE_COUNTRYCODE",
            .email_address => "EMAIL_ADDRESS",
            .unique_id => "UNIQUE_ID",
            .date => "DATE",
            .string => "STRING",
            .provider_id => "PROVIDER_ID",
            .ipv4 => "IPV4",
            .ipv6 => "IPV6",
            .maid => "MAID",
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
