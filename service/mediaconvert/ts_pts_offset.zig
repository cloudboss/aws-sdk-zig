const std = @import("std");

/// Specify the initial presentation timestamp (PTS) offset for your transport
/// stream output. To let MediaConvert automatically determine the initial PTS
/// offset: Keep the default value, Auto. We recommend that you choose Auto for
/// the widest player compatibility. The initial PTS will be at least two
/// seconds and vary depending on your output's bitrate, HRD buffer size and HRD
/// buffer initial fill percentage. To manually specify an initial PTS offset:
/// Choose Seconds or Milliseconds. Then specify the number of seconds or
/// milliseconds with PTS offset.
pub const TsPtsOffset = enum {
    auto,
    seconds,
    milliseconds,

    pub const json_field_names = .{
        .auto = "AUTO",
        .seconds = "SECONDS",
        .milliseconds = "MILLISECONDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .seconds => "SECONDS",
            .milliseconds => "MILLISECONDS",
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
