const std = @import("std");

pub const TargetCapacityType = enum {
    on_demand_capacity_reservation,
    capacity_block,
    interruptible_capacity_reservation,
    on_demand,

    pub const json_field_names = .{
        .on_demand_capacity_reservation = "on-demand-capacity-reservation",
        .capacity_block = "capacity-block",
        .interruptible_capacity_reservation = "interruptible-capacity-reservation",
        .on_demand = "on-demand",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand_capacity_reservation => "on-demand-capacity-reservation",
            .capacity_block => "capacity-block",
            .interruptible_capacity_reservation => "interruptible-capacity-reservation",
            .on_demand => "on-demand",
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
