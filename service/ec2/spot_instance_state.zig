const std = @import("std");

pub const SpotInstanceState = enum {
    open,
    active,
    closed,
    cancelled,
    failed,
    disabled,

    pub const json_field_names = .{
        .open = "open",
        .active = "active",
        .closed = "closed",
        .cancelled = "cancelled",
        .failed = "failed",
        .disabled = "disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "open",
            .active => "active",
            .closed => "closed",
            .cancelled => "cancelled",
            .failed => "failed",
            .disabled => "disabled",
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
