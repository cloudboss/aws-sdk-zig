const std = @import("std");

pub const InstanceLifecycle = enum {
    spot,
    on_demand,
    interruptible_capacity_reservation,
    capacity_block,

    pub const json_field_names = .{
        .spot = "spot",
        .on_demand = "on-demand",
        .interruptible_capacity_reservation = "interruptible-capacity-reservation",
        .capacity_block = "capacity-block",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spot => "spot",
            .on_demand => "on-demand",
            .interruptible_capacity_reservation => "interruptible-capacity-reservation",
            .capacity_block => "capacity-block",
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
