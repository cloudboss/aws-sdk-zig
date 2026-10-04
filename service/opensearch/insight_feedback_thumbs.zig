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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
