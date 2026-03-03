const std = @import("std");

/// Applies only to 29.97 fps outputs. When this feature is enabled, the service
/// will use drop-frame timecode on outputs. If it is not possible to use
/// drop-frame timecode, the system will fall back to non-drop-frame. This
/// setting is enabled by default when Timecode insertion or Timecode track is
/// enabled.
pub const DropFrameTimecode = enum {
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
