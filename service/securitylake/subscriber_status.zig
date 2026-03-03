const std = @import("std");

pub const SubscriberStatus = enum {
    active,
    deactivated,
    pending,
    ready,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deactivated = "DEACTIVATED",
        .pending = "PENDING",
        .ready = "READY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .deactivated => "DEACTIVATED",
            .pending => "PENDING",
            .ready => "READY",
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
