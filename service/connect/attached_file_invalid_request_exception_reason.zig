const std = @import("std");

pub const AttachedFileInvalidRequestExceptionReason = enum {
    invalid_file_size,
    invalid_file_type,
    invalid_file_name,

    pub const json_field_names = .{
        .invalid_file_size = "INVALID_FILE_SIZE",
        .invalid_file_type = "INVALID_FILE_TYPE",
        .invalid_file_name = "INVALID_FILE_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_file_size => "INVALID_FILE_SIZE",
            .invalid_file_type => "INVALID_FILE_TYPE",
            .invalid_file_name => "INVALID_FILE_NAME",
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
