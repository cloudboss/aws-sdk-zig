const std = @import("std");

/// Specify whether MediaConvert automatically attempts to prevent decoder
/// buffer underflows in your transport stream output. Use if you are seeing
/// decoder buffer underflows in your output and are unable to increase your
/// transport stream's bitrate. For most workflows: We recommend that you keep
/// the default value, Disabled. To prevent decoder buffer underflows in your
/// output, when possible: Choose Enabled. Note that if MediaConvert prevents a
/// decoder buffer underflow in your output, output video quality is reduced and
/// your job will take longer to complete.
pub const M2tsPreventBufferUnderflow = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
