const std = @import("std");

/// When set to WHEN_POSSIBLE, input DD+ audio will be passed through if it is
/// present on the input. this detection is dynamic over the life of the
/// transcode. Inputs that alternate between DD+ and non-DD+ content will have a
/// consistent DD+ output as the system alternates between passthrough and
/// encoding.
pub const Eac3PassthroughControl = enum {
    when_possible,
    no_passthrough,

    pub const json_field_names = .{
        .when_possible = "WHEN_POSSIBLE",
        .no_passthrough = "NO_PASSTHROUGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .when_possible => "WHEN_POSSIBLE",
            .no_passthrough => "NO_PASSTHROUGH",
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
