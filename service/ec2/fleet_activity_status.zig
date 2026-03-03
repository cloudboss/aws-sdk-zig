const std = @import("std");

pub const FleetActivityStatus = enum {
    @"error",
    pending_fulfillment,
    pending_termination,
    fulfilled,

    pub const json_field_names = .{
        .@"error" = "error",
        .pending_fulfillment = "pending_fulfillment",
        .pending_termination = "pending_termination",
        .fulfilled = "fulfilled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "error",
            .pending_fulfillment => "pending_fulfillment",
            .pending_termination => "pending_termination",
            .fulfilled => "fulfilled",
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
