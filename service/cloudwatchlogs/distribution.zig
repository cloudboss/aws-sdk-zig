const std = @import("std");

/// The method used to distribute log data to the destination, which can be
/// either random
/// or grouped by log stream.
pub const Distribution = enum {
    random,
    by_log_stream,

    pub const json_field_names = .{
        .random = "Random",
        .by_log_stream = "ByLogStream",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .random => "Random",
            .by_log_stream => "ByLogStream",
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
