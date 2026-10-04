const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_page_token,
    invalid_parameter_value,

    pub const json_field_names = .{
        .invalid_page_token = "INVALID_PAGE_TOKEN",
        .invalid_parameter_value = "INVALID_PARAMETER_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_page_token => "INVALID_PAGE_TOKEN",
            .invalid_parameter_value => "INVALID_PARAMETER_VALUE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
