const std = @import("std");

/// Use Deblocking to improve the video quality of your output by smoothing the
/// edges of macroblock artifacts created during video compression. To reduce
/// blocking artifacts at block boundaries, and improve overall video quality:
/// Keep the default value, Enabled. To not apply any deblocking: Choose
/// Disabled. Visible block edge artifacts might appear in the output,
/// especially at lower bitrates.
pub const H265Deblocking = enum {
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
