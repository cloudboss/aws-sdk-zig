const std = @import("std");

pub const DeviceType = enum {
    gcm,
    apns,
    apns_sandbox,

    pub const json_field_names = .{
        .gcm = "GCM",
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gcm => "GCM",
            .apns => "APNS",
            .apns_sandbox => "APNS_SANDBOX",
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
