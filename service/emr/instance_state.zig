const std = @import("std");

pub const InstanceState = enum {
    awaiting_fulfillment,
    provisioning,
    bootstrapping,
    running,
    terminated,

    pub const json_field_names = .{
        .awaiting_fulfillment = "AWAITING_FULFILLMENT",
        .provisioning = "PROVISIONING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .terminated = "TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .awaiting_fulfillment => "AWAITING_FULFILLMENT",
            .provisioning => "PROVISIONING",
            .bootstrapping => "BOOTSTRAPPING",
            .running => "RUNNING",
            .terminated => "TERMINATED",
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
