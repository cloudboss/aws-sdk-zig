const std = @import("std");

pub const DriftStatus = enum {
    not_checked,
    not_detected,
    detected,

    pub const json_field_names = .{
        .not_checked = "NotChecked",
        .not_detected = "NotDetected",
        .detected = "Detected",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_checked => "NotChecked",
            .not_detected => "NotDetected",
            .detected => "Detected",
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
