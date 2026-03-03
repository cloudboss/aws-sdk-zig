const std = @import("std");

pub const ResourceToTag = enum {
    lambda_function,

    pub const json_field_names = .{
        .lambda_function = "lambda-function",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lambda_function => "lambda-function",
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
