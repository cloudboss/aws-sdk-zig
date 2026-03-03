const std = @import("std");

pub const AccessDeniedForDependencyExceptionReason = enum {
    access_denied_during_create_service_linked_role,

    pub const json_field_names = .{
        .access_denied_during_create_service_linked_role = "ACCESS_DENIED_DURING_CREATE_SERVICE_LINKED_ROLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied_during_create_service_linked_role => "ACCESS_DENIED_DURING_CREATE_SERVICE_LINKED_ROLE",
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
