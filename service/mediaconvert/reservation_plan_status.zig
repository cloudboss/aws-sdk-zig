const std = @import("std");

/// Specifies whether the pricing plan for your reserved queue is ACTIVE or
/// EXPIRED.
pub const ReservationPlanStatus = enum {
    active,
    expired,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .expired => "EXPIRED",
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
