const std = @import("std");

pub const TargetTypeEnum = enum {
    instance,
    ip,
    lambda,
    alb,

    pub const json_field_names = .{
        .instance = "instance",
        .ip = "ip",
        .lambda = "lambda",
        .alb = "alb",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance => "instance",
            .ip => "ip",
            .lambda => "lambda",
            .alb => "alb",
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
