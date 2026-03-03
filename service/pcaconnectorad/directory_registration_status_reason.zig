const std = @import("std");

pub const DirectoryRegistrationStatusReason = enum {
    directory_access_denied,
    directory_resource_not_found,
    directory_not_active,
    directory_not_reachable,
    directory_type_not_supported,
    internal_failure,

    pub const json_field_names = .{
        .directory_access_denied = "DIRECTORY_ACCESS_DENIED",
        .directory_resource_not_found = "DIRECTORY_RESOURCE_NOT_FOUND",
        .directory_not_active = "DIRECTORY_NOT_ACTIVE",
        .directory_not_reachable = "DIRECTORY_NOT_REACHABLE",
        .directory_type_not_supported = "DIRECTORY_TYPE_NOT_SUPPORTED",
        .internal_failure = "INTERNAL_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .directory_access_denied => "DIRECTORY_ACCESS_DENIED",
            .directory_resource_not_found => "DIRECTORY_RESOURCE_NOT_FOUND",
            .directory_not_active => "DIRECTORY_NOT_ACTIVE",
            .directory_not_reachable => "DIRECTORY_NOT_REACHABLE",
            .directory_type_not_supported => "DIRECTORY_TYPE_NOT_SUPPORTED",
            .internal_failure => "INTERNAL_FAILURE",
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
