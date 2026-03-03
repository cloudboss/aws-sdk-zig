const std = @import("std");

pub const RCTAppliedFor = enum {
    replication,
    pull_through_cache,
    create_on_push,

    pub const json_field_names = .{
        .replication = "REPLICATION",
        .pull_through_cache = "PULL_THROUGH_CACHE",
        .create_on_push = "CREATE_ON_PUSH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .replication => "REPLICATION",
            .pull_through_cache => "PULL_THROUGH_CACHE",
            .create_on_push => "CREATE_ON_PUSH",
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
