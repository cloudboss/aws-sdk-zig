const std = @import("std");

pub const SipRuleTriggerType = enum {
    to_phone_number,
    request_uri_hostname,

    pub const json_field_names = .{
        .to_phone_number = "ToPhoneNumber",
        .request_uri_hostname = "RequestUriHostname",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .to_phone_number => "ToPhoneNumber",
            .request_uri_hostname => "RequestUriHostname",
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
