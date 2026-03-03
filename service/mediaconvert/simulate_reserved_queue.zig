const std = @import("std");

/// Enable this setting when you run a test job to estimate how many reserved
/// transcoding slots (RTS) you need. When this is enabled, MediaConvert runs
/// your job from an on-demand queue with similar performance to what you will
/// see with one RTS in a reserved queue. This setting is disabled by default.
pub const SimulateReservedQueue = enum {
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
