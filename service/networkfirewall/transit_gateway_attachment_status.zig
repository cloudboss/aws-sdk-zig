const std = @import("std");

pub const TransitGatewayAttachmentStatus = enum {
    creating,
    deleting,
    deleted,
    failed,
    @"error",
    ready,
    pending_acceptance,
    rejecting,
    rejected,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .ready = "READY",
        .pending_acceptance = "PENDING_ACCEPTANCE",
        .rejecting = "REJECTING",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .failed => "FAILED",
            .@"error" => "ERROR",
            .ready => "READY",
            .pending_acceptance => "PENDING_ACCEPTANCE",
            .rejecting => "REJECTING",
            .rejected => "REJECTED",
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
