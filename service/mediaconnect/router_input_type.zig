const std = @import("std");

pub const RouterInputType = enum {
    standard,
    failover,
    merge,
    mediaconnect_flow,
    medialive_channel,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .failover = "FAILOVER",
        .merge = "MERGE",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
        .medialive_channel = "MEDIALIVE_CHANNEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .failover => "FAILOVER",
            .merge => "MERGE",
            .mediaconnect_flow => "MEDIACONNECT_FLOW",
            .medialive_channel => "MEDIALIVE_CHANNEL",
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
