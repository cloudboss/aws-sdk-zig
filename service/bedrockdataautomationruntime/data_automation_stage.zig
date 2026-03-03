const std = @import("std");

/// Data automation stage.
pub const DataAutomationStage = enum {
    live,
    development,

    pub const json_field_names = .{
        .live = "LIVE",
        .development = "DEVELOPMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .live => "LIVE",
            .development => "DEVELOPMENT",
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
