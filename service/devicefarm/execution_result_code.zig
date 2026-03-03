const std = @import("std");

pub const ExecutionResultCode = enum {
    parsing_failed,
    vpc_endpoint_setup_failed,

    pub const json_field_names = .{
        .parsing_failed = "PARSING_FAILED",
        .vpc_endpoint_setup_failed = "VPC_ENDPOINT_SETUP_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .parsing_failed => "PARSING_FAILED",
            .vpc_endpoint_setup_failed => "VPC_ENDPOINT_SETUP_FAILED",
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
