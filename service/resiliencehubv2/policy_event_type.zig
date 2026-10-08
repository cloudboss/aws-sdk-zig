const std = @import("std");

pub const PolicyEventType = enum {
    policy_attached_to_service,
    policy_detached_from_service,
    policy_sharing_revoked,
    policy_deleted,

    pub const json_field_names = .{
        .policy_attached_to_service = "POLICY_ATTACHED_TO_SERVICE",
        .policy_detached_from_service = "POLICY_DETACHED_FROM_SERVICE",
        .policy_sharing_revoked = "POLICY_SHARING_REVOKED",
        .policy_deleted = "POLICY_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_attached_to_service => "POLICY_ATTACHED_TO_SERVICE",
            .policy_detached_from_service => "POLICY_DETACHED_FROM_SERVICE",
            .policy_sharing_revoked => "POLICY_SHARING_REVOKED",
            .policy_deleted => "POLICY_DELETED",
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
