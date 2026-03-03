const std = @import("std");

pub const Severity = enum {
    info,
    low,
    medium,
    high,
    critical,

    pub const json_field_names = .{
        .info = "Info",
        .low = "Low",
        .medium = "Medium",
        .high = "High",
        .critical = "Critical",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .info => "Info",
            .low => "Low",
            .medium => "Medium",
            .high => "High",
            .critical => "Critical",
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
