const std = @import("std");

pub const VpcPeeringConnectionStateReasonCode = enum {
    initiating_request,
    pending_acceptance,
    active,
    deleted,
    rejected,
    failed,
    expired,
    provisioning,
    deleting,

    pub const json_field_names = .{
        .initiating_request = "initiating-request",
        .pending_acceptance = "pending-acceptance",
        .active = "active",
        .deleted = "deleted",
        .rejected = "rejected",
        .failed = "failed",
        .expired = "expired",
        .provisioning = "provisioning",
        .deleting = "deleting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiating_request => "initiating-request",
            .pending_acceptance => "pending-acceptance",
            .active => "active",
            .deleted => "deleted",
            .rejected => "rejected",
            .failed => "failed",
            .expired => "expired",
            .provisioning => "provisioning",
            .deleting => "deleting",
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
