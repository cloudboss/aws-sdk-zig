const std = @import("std");

pub const PerObjectSyncStatus = enum {
    pending,
    in_sync,
    capacity_constrained,
    not_subscribed,
    deprecated,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_sync = "IN_SYNC",
        .capacity_constrained = "CAPACITY_CONSTRAINED",
        .not_subscribed = "NOT_SUBSCRIBED",
        .deprecated = "DEPRECATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_sync => "IN_SYNC",
            .capacity_constrained => "CAPACITY_CONSTRAINED",
            .not_subscribed => "NOT_SUBSCRIBED",
            .deprecated => "DEPRECATED",
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
