const std = @import("std");

pub const WarningType = enum {
    mutually_exclusive_properties,
    unsupported_properties,
    mutually_exclusive_types,
    excluded_properties,
    excluded_resources,

    pub const json_field_names = .{
        .mutually_exclusive_properties = "MUTUALLY_EXCLUSIVE_PROPERTIES",
        .unsupported_properties = "UNSUPPORTED_PROPERTIES",
        .mutually_exclusive_types = "MUTUALLY_EXCLUSIVE_TYPES",
        .excluded_properties = "EXCLUDED_PROPERTIES",
        .excluded_resources = "EXCLUDED_RESOURCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mutually_exclusive_properties => "MUTUALLY_EXCLUSIVE_PROPERTIES",
            .unsupported_properties => "UNSUPPORTED_PROPERTIES",
            .mutually_exclusive_types => "MUTUALLY_EXCLUSIVE_TYPES",
            .excluded_properties => "EXCLUDED_PROPERTIES",
            .excluded_resources => "EXCLUDED_RESOURCES",
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
