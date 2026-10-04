const std = @import("std");

pub const Platform = enum {
    apns,
    apns_sandbox,
    gcm,
    adm,

    pub const json_field_names = .{
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
        .gcm = "GCM",
        .adm = "ADM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .apns => "APNS",
            .apns_sandbox => "APNS_SANDBOX",
            .gcm => "GCM",
            .adm => "ADM",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
