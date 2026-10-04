const std = @import("std");

pub const MarketType = enum {
    spot,
    capacity_block,
    interruptible_capacity_reservation,
    on_demand,

    pub const json_field_names = .{
        .spot = "spot",
        .capacity_block = "capacity-block",
        .interruptible_capacity_reservation = "interruptible-capacity-reservation",
        .on_demand = "on-demand",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spot => "spot",
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
