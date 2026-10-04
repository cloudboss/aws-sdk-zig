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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
