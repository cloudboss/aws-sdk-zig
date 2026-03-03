const std = @import("std");

pub const ShardFilterType = enum {
    after_shard_id,
    at_trim_horizon,
    from_trim_horizon,
    at_latest,
    at_timestamp,
    from_timestamp,

    pub const json_field_names = .{
        .after_shard_id = "AFTER_SHARD_ID",
        .at_trim_horizon = "AT_TRIM_HORIZON",
        .from_trim_horizon = "FROM_TRIM_HORIZON",
        .at_latest = "AT_LATEST",
        .at_timestamp = "AT_TIMESTAMP",
        .from_timestamp = "FROM_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .after_shard_id => "AFTER_SHARD_ID",
            .at_trim_horizon => "AT_TRIM_HORIZON",
            .from_trim_horizon => "FROM_TRIM_HORIZON",
            .at_latest => "AT_LATEST",
            .at_timestamp => "AT_TIMESTAMP",
            .from_timestamp => "FROM_TIMESTAMP",
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
