const std = @import("std");

pub const HarnessTruncationStrategy = enum {
    sliding_window,
    summarization,
    none,

    pub const json_field_names = .{
        .sliding_window = "sliding_window",
        .summarization = "summarization",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sliding_window => "sliding_window",
            .summarization => "summarization",
            .none => "none",
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
