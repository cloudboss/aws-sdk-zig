const std = @import("std");

pub const UnprocessableExceptionReason = enum {
    query_timeout,
    internal_limit_exceeded,
    memory_limit_exceeded,
    storage_limit_exceeded,
    partition_full,

    pub const json_field_names = .{
        .query_timeout = "QUERY_TIMEOUT",
        .internal_limit_exceeded = "INTERNAL_LIMIT_EXCEEDED",
        .memory_limit_exceeded = "MEMORY_LIMIT_EXCEEDED",
        .storage_limit_exceeded = "STORAGE_LIMIT_EXCEEDED",
        .partition_full = "PARTITION_FULL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .query_timeout => "QUERY_TIMEOUT",
            .internal_limit_exceeded => "INTERNAL_LIMIT_EXCEEDED",
            .memory_limit_exceeded => "MEMORY_LIMIT_EXCEEDED",
            .storage_limit_exceeded => "STORAGE_LIMIT_EXCEEDED",
            .partition_full => "PARTITION_FULL",
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
