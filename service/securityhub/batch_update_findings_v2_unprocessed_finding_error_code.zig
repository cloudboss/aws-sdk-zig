const std = @import("std");

pub const BatchUpdateFindingsV2UnprocessedFindingErrorCode = enum {
    resource_not_found_exception,
    validation_exception,
    internal_server_exception,
    conflict_exception,

    pub const json_field_names = .{
        .resource_not_found_exception = "ResourceNotFoundException",
        .validation_exception = "ValidationException",
        .internal_server_exception = "InternalServerException",
        .conflict_exception = "ConflictException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found_exception => "ResourceNotFoundException",
            .validation_exception => "ValidationException",
            .internal_server_exception => "InternalServerException",
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
