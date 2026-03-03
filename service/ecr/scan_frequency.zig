const std = @import("std");

pub const ScanFrequency = enum {
    scan_on_push,
    continuous_scan,
    manual,

    pub const json_field_names = .{
        .scan_on_push = "SCAN_ON_PUSH",
        .continuous_scan = "CONTINUOUS_SCAN",
        .manual = "MANUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scan_on_push => "SCAN_ON_PUSH",
            .continuous_scan => "CONTINUOUS_SCAN",
            .manual => "MANUAL",
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
