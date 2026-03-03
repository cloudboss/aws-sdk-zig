const std = @import("std");

pub const LineItemStatus = enum {
    preparing,
    building,
    shipped,
    delivered,
    installing,
    installed,
    @"error",
    cancelled,
    replaced,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .building = "BUILDING",
        .shipped = "SHIPPED",
        .delivered = "DELIVERED",
        .installing = "INSTALLING",
        .installed = "INSTALLED",
        .@"error" = "ERROR",
        .cancelled = "CANCELLED",
        .replaced = "REPLACED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preparing => "PREPARING",
            .building => "BUILDING",
            .shipped => "SHIPPED",
            .delivered => "DELIVERED",
            .installing => "INSTALLING",
            .installed => "INSTALLED",
            .@"error" => "ERROR",
            .cancelled => "CANCELLED",
            .replaced => "REPLACED",
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
