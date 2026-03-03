const std = @import("std");

pub const Severity = enum {
    critical,
    high,
    medium,
    low,
    info,

    pub const json_field_names = .{
        .critical = "Critical",
        .high = "High",
        .medium = "Medium",
        .low = "Low",
        .info = "Info",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .critical => "Critical",
            .high => "High",
            .medium => "Medium",
            .low => "Low",
            .info => "Info",
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
