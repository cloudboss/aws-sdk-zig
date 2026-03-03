const std = @import("std");

pub const InternalServerExceptionReason = enum {
    invalid_model_generation,
    token_limit_exceeded,

    pub const json_field_names = .{
        .invalid_model_generation = "InvalidModelGeneration",
        .token_limit_exceeded = "RequestTokenLimitExceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_model_generation => "InvalidModelGeneration",
            .token_limit_exceeded => "RequestTokenLimitExceeded",
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
