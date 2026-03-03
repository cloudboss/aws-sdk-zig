const std = @import("std");

/// To use the available style, color, and position information from your input
/// captions: Set Style passthrough to Enabled. Note that MediaConvert uses
/// default settings for any missing style or position information in your input
/// captions To ignore the style and position information from your input
/// captions and use default settings: Leave blank or keep the default value,
/// Disabled. Default settings include white text with black outlining,
/// bottom-center positioning, and automatic sizing. Whether you set Style
/// passthrough to enabled or not, you can also choose to manually override any
/// of the individual style and position settings. You can also override any
/// fonts by manually specifying custom font files.
pub const BurnInSubtitleStylePassthrough = enum {
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
