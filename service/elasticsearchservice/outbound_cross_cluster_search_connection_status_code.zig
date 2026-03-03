const std = @import("std");

pub const OutboundCrossClusterSearchConnectionStatusCode = enum {
    pending_acceptance,
    validating,
    validation_failed,
    provisioning,
    active,
    rejected,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .rejected = "REJECTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_acceptance => "PENDING_ACCEPTANCE",
            .validating => "VALIDATING",
            .validation_failed => "VALIDATION_FAILED",
            .provisioning => "PROVISIONING",
            .active => "ACTIVE",
            .rejected => "REJECTED",
            .deleting => "DELETING",
            .deleted => "DELETED",
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
