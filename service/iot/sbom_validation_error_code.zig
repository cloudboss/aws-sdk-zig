const std = @import("std");

pub const SbomValidationErrorCode = enum {
    incompatible_format,
    file_size_limit_exceeded,

    pub const json_field_names = .{
        .incompatible_format = "INCOMPATIBLE_FORMAT",
        .file_size_limit_exceeded = "FILE_SIZE_LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incompatible_format => "INCOMPATIBLE_FORMAT",
            .file_size_limit_exceeded => "FILE_SIZE_LIMIT_EXCEEDED",
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
