const std = @import("std");

pub const MemoryStrategyType = enum {
    semantic,
    summarization,
    user_preference,
    custom,
    episodic,

    pub const json_field_names = .{
        .semantic = "SEMANTIC",
        .summarization = "SUMMARIZATION",
        .user_preference = "USER_PREFERENCE",
        .custom = "CUSTOM",
        .episodic = "EPISODIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .semantic => "SEMANTIC",
            .summarization => "SUMMARIZATION",
            .user_preference => "USER_PREFERENCE",
            .custom => "CUSTOM",
            .episodic => "EPISODIC",
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
