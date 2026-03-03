const std = @import("std");

pub const ReasonCode = enum {
    aws_service_access_disabled,
    delegated_administrator_deregistered,
    organization_deleted,
    service_linked_role_creation_failed,

    pub const json_field_names = .{
        .aws_service_access_disabled = "AWS_SERVICE_ACCESS_DISABLED",
        .delegated_administrator_deregistered = "DELEGATED_ADMINISTRATOR_DEREGISTERED",
        .organization_deleted = "ORGANIZATION_DELETED",
        .service_linked_role_creation_failed = "SERVICE_LINKED_ROLE_CREATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_service_access_disabled => "AWS_SERVICE_ACCESS_DISABLED",
            .delegated_administrator_deregistered => "DELEGATED_ADMINISTRATOR_DEREGISTERED",
            .organization_deleted => "ORGANIZATION_DELETED",
            .service_linked_role_creation_failed => "SERVICE_LINKED_ROLE_CREATION_FAILED",
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
