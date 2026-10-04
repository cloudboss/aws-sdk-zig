const std = @import("std");

pub const PlacementStrategy = enum {
    cluster,
    spread,
    partition,
    precision_time,

    pub const json_field_names = .{
        .cluster = "cluster",
        .spread = "spread",
        .partition = "partition",
        .precision_time = "precision-time",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cluster => "cluster",
            .spread => "spread",
            .partition => "partition",
            .precision_time => "precision-time",
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
