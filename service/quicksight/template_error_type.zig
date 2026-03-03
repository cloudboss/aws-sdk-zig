const std = @import("std");

pub const TemplateErrorType = enum {
    source_not_found,
    data_set_not_found,
    internal_failure,
    access_denied,

    pub const json_field_names = .{
        .source_not_found = "SOURCE_NOT_FOUND",
        .data_set_not_found = "DATA_SET_NOT_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .access_denied = "ACCESS_DENIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_not_found => "SOURCE_NOT_FOUND",
            .data_set_not_found => "DATA_SET_NOT_FOUND",
            .internal_failure => "INTERNAL_FAILURE",
            .access_denied => "ACCESS_DENIED",
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
