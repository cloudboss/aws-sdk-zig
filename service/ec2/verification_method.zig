const std = @import("std");

pub const VerificationMethod = enum {
    remarks_x_509,
    dns_token,

    pub const json_field_names = .{
        .remarks_x_509 = "remarks-x509",
        .dns_token = "dns-token",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .remarks_x_509 => "remarks-x509",
            .dns_token => "dns-token",
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
