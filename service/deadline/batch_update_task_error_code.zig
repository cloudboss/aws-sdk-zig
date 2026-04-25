const std = @import("std");

pub const BatchUpdateTaskErrorCode = enum {
    conflict_exception,
    internal_server_error_exception,
    resource_not_found_exception,
    validation_exception,
    access_denied_exception,
    throttling_exception,

    pub const json_field_names = .{
        .conflict_exception = "ConflictException",
        .internal_server_error_exception = "InternalServerErrorException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .validation_exception = "ValidationException",
        .access_denied_exception = "AccessDeniedException",
        .throttling_exception = "ThrottlingException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conflict_exception => "ConflictException",
            .internal_server_error_exception => "InternalServerErrorException",
            .resource_not_found_exception => "ResourceNotFoundException",
            .validation_exception => "ValidationException",
            .access_denied_exception => "AccessDeniedException",
            .throttling_exception => "ThrottlingException",
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
