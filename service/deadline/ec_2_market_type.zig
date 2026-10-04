const std = @import("std");

pub const Ec2MarketType = enum {
    on_demand,
    spot,
    wait_and_save,

    pub const json_field_names = .{
        .on_demand = "on-demand",
        .spot = "spot",
        .wait_and_save = "wait-and-save",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand => "on-demand",
            .spot => "spot",
            .wait_and_save => "wait-and-save",
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
