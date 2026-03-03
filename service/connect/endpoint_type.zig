const std = @import("std");

pub const EndpointType = enum {
    telephone_number,
    voip,
    contact_flow,
    connect_phonenumber_arn,
    email_address,

    pub const json_field_names = .{
        .telephone_number = "TELEPHONE_NUMBER",
        .voip = "VOIP",
        .contact_flow = "CONTACT_FLOW",
        .connect_phonenumber_arn = "CONNECT_PHONENUMBER_ARN",
        .email_address = "EMAIL_ADDRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .telephone_number => "TELEPHONE_NUMBER",
            .voip => "VOIP",
            .contact_flow => "CONTACT_FLOW",
            .connect_phonenumber_arn => "CONNECT_PHONENUMBER_ARN",
            .email_address => "EMAIL_ADDRESS",
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
