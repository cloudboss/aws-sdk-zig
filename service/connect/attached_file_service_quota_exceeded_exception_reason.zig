const std = @import("std");

pub const AttachedFileServiceQuotaExceededExceptionReason = enum {
    total_file_size_exceeded,
    total_file_count_exceeded,

    pub const json_field_names = .{
        .total_file_size_exceeded = "TOTAL_FILE_SIZE_EXCEEDED",
        .total_file_count_exceeded = "TOTAL_FILE_COUNT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .total_file_size_exceeded => "TOTAL_FILE_SIZE_EXCEEDED",
            .total_file_count_exceeded => "TOTAL_FILE_COUNT_EXCEEDED",
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
