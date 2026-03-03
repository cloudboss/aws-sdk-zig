const std = @import("std");

pub const ErrorCode = enum {
    internal_service_exception,
    invalid_parameter_exception,

    pub const json_field_names = .{
        .internal_service_exception = "InternalServiceException",
        .invalid_parameter_exception = "InvalidParameterException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_service_exception => "InternalServiceException",
            .invalid_parameter_exception => "InvalidParameterException",
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
