const std = @import("std");

pub const Compatibility = enum {
    none,
    disabled,
    backward,
    backward_all,
    forward,
    forward_all,
    full,
    full_all,

    pub const json_field_names = .{
        .none = "NONE",
        .disabled = "DISABLED",
        .backward = "BACKWARD",
        .backward_all = "BACKWARD_ALL",
        .forward = "FORWARD",
        .forward_all = "FORWARD_ALL",
        .full = "FULL",
        .full_all = "FULL_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .disabled => "DISABLED",
            .backward => "BACKWARD",
            .backward_all => "BACKWARD_ALL",
            .forward => "FORWARD",
            .forward_all => "FORWARD_ALL",
            .full => "FULL",
            .full_all => "FULL_ALL",
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
