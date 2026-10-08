const std = @import("std");

pub const SystemEventType = enum {
    system_created,
    system_deleted,
    system_user_journey_created,
    system_user_journey_updated,
    system_user_journey_deleted,
    system_service_associated,
    system_service_disassociated,
    system_policy_associated,
    system_policy_disassociated,

    pub const json_field_names = .{
        .system_created = "SYSTEM_CREATED",
        .system_deleted = "SYSTEM_DELETED",
        .system_user_journey_created = "SYSTEM_USER_JOURNEY_CREATED",
        .system_user_journey_updated = "SYSTEM_USER_JOURNEY_UPDATED",
        .system_user_journey_deleted = "SYSTEM_USER_JOURNEY_DELETED",
        .system_service_associated = "SYSTEM_SERVICE_ASSOCIATED",
        .system_service_disassociated = "SYSTEM_SERVICE_DISASSOCIATED",
        .system_policy_associated = "SYSTEM_POLICY_ASSOCIATED",
        .system_policy_disassociated = "SYSTEM_POLICY_DISASSOCIATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .system_created => "SYSTEM_CREATED",
            .system_deleted => "SYSTEM_DELETED",
            .system_user_journey_created => "SYSTEM_USER_JOURNEY_CREATED",
            .system_user_journey_updated => "SYSTEM_USER_JOURNEY_UPDATED",
            .system_user_journey_deleted => "SYSTEM_USER_JOURNEY_DELETED",
            .system_service_associated => "SYSTEM_SERVICE_ASSOCIATED",
            .system_service_disassociated => "SYSTEM_SERVICE_DISASSOCIATED",
            .system_policy_associated => "SYSTEM_POLICY_ASSOCIATED",
            .system_policy_disassociated => "SYSTEM_POLICY_DISASSOCIATED",
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
