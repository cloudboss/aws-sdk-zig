const std = @import("std");

pub const DefaultTargetCapacityType = enum {
    spot,
    on_demand,
    capacity_block,
    reserved_capacity,

    pub const json_field_names = .{
        .spot = "spot",
        .on_demand = "on-demand",
        .capacity_block = "capacity-block",
        .reserved_capacity = "reserved-capacity",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spot => "spot",
            .on_demand => "on-demand",
            .capacity_block => "capacity-block",
            .reserved_capacity => "reserved-capacity",
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
