const std = @import("std");

pub const DataSourceErrorInfoType = enum {
    access_denied,
    copy_source_not_found,
    timeout,
    engine_version_not_supported,
    unknown_host,
    generic_sql_failure,
    conflict,
    unknown,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .copy_source_not_found = "COPY_SOURCE_NOT_FOUND",
        .timeout = "TIMEOUT",
        .engine_version_not_supported = "ENGINE_VERSION_NOT_SUPPORTED",
        .unknown_host = "UNKNOWN_HOST",
        .generic_sql_failure = "GENERIC_SQL_FAILURE",
        .conflict = "CONFLICT",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .copy_source_not_found => "COPY_SOURCE_NOT_FOUND",
            .timeout => "TIMEOUT",
            .engine_version_not_supported => "ENGINE_VERSION_NOT_SUPPORTED",
            .unknown_host => "UNKNOWN_HOST",
            .generic_sql_failure => "GENERIC_SQL_FAILURE",
            .conflict => "CONFLICT",
            .unknown => "UNKNOWN",
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
