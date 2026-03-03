const std = @import("std");

/// The attempt name of attempts of a prompt.
pub const PromptAttempt = enum {
    initial,
    retry_1,
    retry_2,
    retry_3,
    retry_4,
    retry_5,

    pub const json_field_names = .{
        .initial = "Initial",
        .retry_1 = "Retry1",
        .retry_2 = "Retry2",
        .retry_3 = "Retry3",
        .retry_4 = "Retry4",
        .retry_5 = "Retry5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initial => "Initial",
            .retry_1 => "Retry1",
            .retry_2 => "Retry2",
            .retry_3 => "Retry3",
            .retry_4 => "Retry4",
            .retry_5 => "Retry5",
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
