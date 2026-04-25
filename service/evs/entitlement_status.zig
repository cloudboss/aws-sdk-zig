const std = @import("std");

pub const EntitlementStatus = enum {
    creating,
    created,
    deleted,
    at_risk,
    entitlement_removed,
    create_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleted = "DELETED",
        .at_risk = "AT_RISK",
        .entitlement_removed = "ENTITLEMENT_REMOVED",
        .create_failed = "CREATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .created => "CREATED",
            .deleted => "DELETED",
            .at_risk => "AT_RISK",
            .entitlement_removed => "ENTITLEMENT_REMOVED",
            .create_failed => "CREATE_FAILED",
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
