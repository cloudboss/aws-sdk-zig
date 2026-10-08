const std = @import("std");

pub const PolicyDisassociationReason = enum {
    replaced_by_update,
    sharing_revoked,
    policy_deleted,

    pub const json_field_names = .{
        .replaced_by_update = "REPLACED_BY_UPDATE",
        .sharing_revoked = "SHARING_REVOKED",
        .policy_deleted = "POLICY_DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .replaced_by_update => "REPLACED_BY_UPDATE",
            .sharing_revoked => "SHARING_REVOKED",
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
