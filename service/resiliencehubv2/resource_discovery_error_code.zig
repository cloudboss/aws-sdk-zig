const std = @import("std");

pub const ResourceDiscoveryErrorCode = enum {
    invalid_permissions,
    stack_not_found,
    cluster_not_found,
    state_file_not_found,
    access_denied,
    unsupported_cluster,
    internal_error,

    pub const json_field_names = .{
        .invalid_permissions = "INVALID_PERMISSIONS",
        .stack_not_found = "STACK_NOT_FOUND",
        .cluster_not_found = "CLUSTER_NOT_FOUND",
        .state_file_not_found = "STATE_FILE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .unsupported_cluster = "UNSUPPORTED_CLUSTER",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_permissions => "INVALID_PERMISSIONS",
            .stack_not_found => "STACK_NOT_FOUND",
            .cluster_not_found => "CLUSTER_NOT_FOUND",
            .state_file_not_found => "STATE_FILE_NOT_FOUND",
            .access_denied => "ACCESS_DENIED",
            .unsupported_cluster => "UNSUPPORTED_CLUSTER",
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
