const std = @import("std");

pub const OpenZFSReadCacheSizingMode = enum {
    no_cache,
    user_provisioned,
    proportional_to_throughput_capacity,

    pub const json_field_names = .{
        .no_cache = "NO_CACHE",
        .user_provisioned = "USER_PROVISIONED",
        .proportional_to_throughput_capacity = "PROPORTIONAL_TO_THROUGHPUT_CAPACITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_cache => "NO_CACHE",
            .user_provisioned => "USER_PROVISIONED",
            .proportional_to_throughput_capacity => "PROPORTIONAL_TO_THROUGHPUT_CAPACITY",
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
