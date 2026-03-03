const std = @import("std");

pub const sortKeyType = enum {
    service_namespace_ascending,
    service_namespace_descending,
    last_authenticated_time_ascending,
    last_authenticated_time_descending,

    pub const json_field_names = .{
        .service_namespace_ascending = "SERVICE_NAMESPACE_ASCENDING",
        .service_namespace_descending = "SERVICE_NAMESPACE_DESCENDING",
        .last_authenticated_time_ascending = "LAST_AUTHENTICATED_TIME_ASCENDING",
        .last_authenticated_time_descending = "LAST_AUTHENTICATED_TIME_DESCENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_namespace_ascending => "SERVICE_NAMESPACE_ASCENDING",
            .service_namespace_descending => "SERVICE_NAMESPACE_DESCENDING",
            .last_authenticated_time_ascending => "LAST_AUTHENTICATED_TIME_ASCENDING",
            .last_authenticated_time_descending => "LAST_AUTHENTICATED_TIME_DESCENDING",
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
