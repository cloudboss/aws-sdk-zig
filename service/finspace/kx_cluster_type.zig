const std = @import("std");

pub const KxClusterType = enum {
    hdb,
    rdb,
    gateway,
    gp,
    tickerplant,

    pub const json_field_names = .{
        .hdb = "HDB",
        .rdb = "RDB",
        .gateway = "GATEWAY",
        .gp = "GP",
        .tickerplant = "TICKERPLANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hdb => "HDB",
            .rdb => "RDB",
            .gateway => "GATEWAY",
            .gp => "GP",
            .tickerplant => "TICKERPLANT",
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
