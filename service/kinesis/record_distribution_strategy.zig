const std = @import("std");

pub const RecordDistributionStrategy = enum {
    auto,
    user_partition_key,

    pub const json_field_names = .{
        .auto = "AUTO",
        .user_partition_key = "USER_PARTITION_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .user_partition_key => "USER_PARTITION_KEY",
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
