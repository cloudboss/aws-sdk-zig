const std = @import("std");

pub const JobEntityErrorCode = enum {
    access_denied_exception,
    internal_server_exception,
    validation_exception,
    resource_not_found_exception,
    max_payload_size_exceeded,
    conflict_exception,

    pub const json_field_names = .{
        .access_denied_exception = "AccessDeniedException",
        .internal_server_exception = "InternalServerException",
        .validation_exception = "ValidationException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .max_payload_size_exceeded = "MaxPayloadSizeExceeded",
        .conflict_exception = "ConflictException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied_exception => "AccessDeniedException",
            .internal_server_exception => "InternalServerException",
            .validation_exception => "ValidationException",
            .resource_not_found_exception => "ResourceNotFoundException",
            .max_payload_size_exceeded => "MaxPayloadSizeExceeded",
            .conflict_exception => "ConflictException",
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
