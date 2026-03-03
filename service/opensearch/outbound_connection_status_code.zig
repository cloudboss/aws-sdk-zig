const std = @import("std");

pub const OutboundConnectionStatusCode = enum {
    validating,
    validation_failed,
    pending_acceptance,
    approved,
    provisioning,
    active,
    rejecting,
    rejected,
    deleting,
    deleted,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .approved = "APPROVED",
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .rejecting = "REJECTING",
        .rejected = "REJECTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validating => "VALIDATING",
            .validation_failed => "VALIDATION_FAILED",
            .pending_acceptance => "PENDING_ACCEPTANCE",
            .approved => "APPROVED",
            .provisioning => "PROVISIONING",
            .active => "ACTIVE",
            .rejecting => "REJECTING",
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
