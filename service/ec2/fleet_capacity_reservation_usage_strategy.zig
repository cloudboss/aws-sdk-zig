const std = @import("std");

pub const FleetCapacityReservationUsageStrategy = enum {
    use_capacity_reservations_first,

    pub const json_field_names = .{
        .use_capacity_reservations_first = "use-capacity-reservations-first",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_capacity_reservations_first => "use-capacity-reservations-first",
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
