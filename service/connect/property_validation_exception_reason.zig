const std = @import("std");

pub const PropertyValidationExceptionReason = enum {
    invalid_format,
    unique_constraint_violated,
    referenced_resource_not_found,
    resource_name_already_exists,
    required_property_missing,
    not_supported,

    pub const json_field_names = .{
        .invalid_format = "INVALID_FORMAT",
        .unique_constraint_violated = "UNIQUE_CONSTRAINT_VIOLATED",
        .referenced_resource_not_found = "REFERENCED_RESOURCE_NOT_FOUND",
        .resource_name_already_exists = "RESOURCE_NAME_ALREADY_EXISTS",
        .required_property_missing = "REQUIRED_PROPERTY_MISSING",
        .not_supported = "NOT_SUPPORTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_format => "INVALID_FORMAT",
            .unique_constraint_violated => "UNIQUE_CONSTRAINT_VIOLATED",
            .referenced_resource_not_found => "REFERENCED_RESOURCE_NOT_FOUND",
            .resource_name_already_exists => "RESOURCE_NAME_ALREADY_EXISTS",
            .required_property_missing => "REQUIRED_PROPERTY_MISSING",
            .not_supported => "NOT_SUPPORTED",
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
