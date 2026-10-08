const std = @import("std");

pub const BatchGetDiscoverableRegistryRecordErrorCode = enum {
    resource_not_found,
    access_denied,
    internal_error,

    pub const json_field_names = .{
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .access_denied => "ACCESS_DENIED",
            .internal_error => "INTERNAL_ERROR",
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
