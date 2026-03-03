const std = @import("std");

pub const ErrorType = enum {
    /// An API request validation exception
    validation_exception,
    /// An API request retrieving an item that can't be found
    resource_not_found_exception,

    pub const json_field_names = .{
        .validation_exception = "VALIDATION_EXCEPTION",
        .resource_not_found_exception = "RESOURCE_NOT_FOUND_EXCEPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation_exception => "VALIDATION_EXCEPTION",
            .resource_not_found_exception => "RESOURCE_NOT_FOUND_EXCEPTION",
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
