const std = @import("std");

pub const CapacityReservationPreference = enum {
    capacity_reservations_only,
    capacity_reservations_first,
    none,
    default,

    pub const json_field_names = .{
        .capacity_reservations_only = "capacity-reservations-only",
        .capacity_reservations_first = "capacity-reservations-first",
        .none = "none",
        .default = "default",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .capacity_reservations_only => "capacity-reservations-only",
            .capacity_reservations_first => "capacity-reservations-first",
            .none => "none",
            .default => "default",
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
