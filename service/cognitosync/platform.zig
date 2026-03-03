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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
