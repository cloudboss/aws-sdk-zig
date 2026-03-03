const std = @import("std");

/// Set Style passthrough to ENABLED to use the available style, color, and
/// position information from your input captions. MediaConvert uses default
/// settings for any missing style and position information in your input
/// captions. Set Style passthrough to DISABLED, or leave blank, to ignore the
/// style and position information from your input captions and use simplified
/// output captions.
pub const SrtStylePassthrough = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
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
