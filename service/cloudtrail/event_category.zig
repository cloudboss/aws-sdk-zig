const std = @import("std");

/// Specifies the event category for which aggregation configuration is enabled.
/// Valid value is Data.
pub const EventCategory = enum {
    insight,

    pub const json_field_names = .{
        .insight = "insight",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insight => "insight",
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
