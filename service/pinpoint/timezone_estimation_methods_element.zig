const std = @import("std");

pub const __TimezoneEstimationMethodsElement = enum {
    phone_number,
    postal_code,

    pub const json_field_names = .{
        .phone_number = "PHONE_NUMBER",
        .postal_code = "POSTAL_CODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .phone_number => "PHONE_NUMBER",
            .postal_code => "POSTAL_CODE",
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
