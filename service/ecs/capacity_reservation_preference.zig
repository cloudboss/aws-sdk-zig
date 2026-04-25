const std = @import("std");

pub const CapacityReservationPreference = enum {
    reservations_only,
    reservations_first,
    reservations_excluded,

    pub const json_field_names = .{
        .reservations_only = "RESERVATIONS_ONLY",
        .reservations_first = "RESERVATIONS_FIRST",
        .reservations_excluded = "RESERVATIONS_EXCLUDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reservations_only => "RESERVATIONS_ONLY",
            .reservations_first => "RESERVATIONS_FIRST",
            .reservations_excluded => "RESERVATIONS_EXCLUDED",
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
