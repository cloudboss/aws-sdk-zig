const std = @import("std");

pub const ValidationExceptionType = enum {
    invalid_format,
    trimmed_data_access,
    expired_iterator,
    expired_next_token,

    pub const json_field_names = .{
        .invalid_format = "InvalidFormat",
        .trimmed_data_access = "TrimmedDataAccess",
        .expired_iterator = "ExpiredIterator",
        .expired_next_token = "ExpiredNextToken",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_format => "InvalidFormat",
            .trimmed_data_access => "TrimmedDataAccess",
            .expired_iterator => "ExpiredIterator",
            .expired_next_token => "ExpiredNextToken",
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
