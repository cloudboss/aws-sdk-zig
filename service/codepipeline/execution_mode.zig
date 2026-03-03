const std = @import("std");

pub const ExecutionMode = enum {
    queued,
    superseded,
    parallel,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .superseded = "SUPERSEDED",
        .parallel = "PARALLEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .superseded => "SUPERSEDED",
            .parallel => "PARALLEL",
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
