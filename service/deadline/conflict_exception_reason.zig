const std = @import("std");

pub const ConflictExceptionReason = enum {
    conflict_exception,
    concurrent_modification,
    resource_already_exists,
    resource_in_use,
    status_conflict,

    pub const json_field_names = .{
        .conflict_exception = "CONFLICT_EXCEPTION",
        .concurrent_modification = "CONCURRENT_MODIFICATION",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .resource_in_use = "RESOURCE_IN_USE",
        .status_conflict = "STATUS_CONFLICT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .conflict_exception => "CONFLICT_EXCEPTION",
            .concurrent_modification => "CONCURRENT_MODIFICATION",
            .resource_already_exists => "RESOURCE_ALREADY_EXISTS",
            .resource_in_use => "RESOURCE_IN_USE",
            .status_conflict => "STATUS_CONFLICT",
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
