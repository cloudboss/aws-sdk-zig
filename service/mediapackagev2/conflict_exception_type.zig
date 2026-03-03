const std = @import("std");

pub const ConflictExceptionType = enum {
    resource_in_use,
    resource_already_exists,
    idempotent_parameter_mismatch,
    conflicting_operation,

    pub const json_field_names = .{
        .resource_in_use = "RESOURCE_IN_USE",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .idempotent_parameter_mismatch = "IDEMPOTENT_PARAMETER_MISMATCH",
        .conflicting_operation = "CONFLICTING_OPERATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_in_use => "RESOURCE_IN_USE",
            .resource_already_exists => "RESOURCE_ALREADY_EXISTS",
            .idempotent_parameter_mismatch => "IDEMPOTENT_PARAMETER_MISMATCH",
            .conflicting_operation => "CONFLICTING_OPERATION",
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
