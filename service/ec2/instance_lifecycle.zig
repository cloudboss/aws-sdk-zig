const std = @import("std");

pub const InstanceLifecycle = enum {
    spot,
    on_demand,
    interruptible_capacity_reservation,

    pub const json_field_names = .{
        .spot = "spot",
        .on_demand = "on-demand",
        .interruptible_capacity_reservation = "interruptible-capacity-reservation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spot => "spot",
            .on_demand => "on-demand",
            .interruptible_capacity_reservation => "interruptible-capacity-reservation",
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
