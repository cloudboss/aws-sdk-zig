const std = @import("std");

/// Specify whether to apply input filtering to improve the video quality of
/// your input. To apply filtering depending on your input type and quality:
/// Choose Auto. To apply no filtering: Choose Disable. To apply filtering
/// regardless of your input type and quality: Choose Force. When you do, you
/// must also specify a value for Filter strength.
pub const InputFilterEnable = enum {
    auto,
    disable,
    force,

    pub const json_field_names = .{
        .auto = "AUTO",
        .disable = "DISABLE",
        .force = "FORCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .disable => "DISABLE",
            .force => "FORCE",
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
