const std = @import("std");

/// The thumbs up or thumbs down feedback for an insight. Possible values are
/// `Up` and `Down`.
pub const InsightFeedbackThumbs = enum {
    up,
    down,

    pub const json_field_names = .{
        .up = "Up",
        .down = "Down",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .up => "Up",
            .down => "Down",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
