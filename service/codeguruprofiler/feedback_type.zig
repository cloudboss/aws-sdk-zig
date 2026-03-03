const std = @import("std");

pub const FeedbackType = enum {
    /// Profiler recommendation flagged as useful.
    positive,
    /// Profiler recommendation flagged as not useful.
    negative,

    pub const json_field_names = .{
        .positive = "Positive",
        .negative = "Negative",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .positive => "Positive",
            .negative => "Negative",
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
