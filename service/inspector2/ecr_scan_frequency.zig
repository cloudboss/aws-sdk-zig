const std = @import("std");

pub const EcrScanFrequency = enum {
    manual,
    scan_on_push,
    continuous_scan,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scan_on_push = "SCAN_ON_PUSH",
        .continuous_scan = "CONTINUOUS_SCAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual => "MANUAL",
            .scan_on_push => "SCAN_ON_PUSH",
            .continuous_scan => "CONTINUOUS_SCAN",
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
