const std = @import("std");

pub const TransitGatewayAttachmentState = enum {
    initiating,
    initiating_request,
    pending_acceptance,
    rolling_back,
    pending,
    available,
    modifying,
    deleting,
    deleted,
    failed,
    rejected,
    rejecting,
    failing,

    pub const json_field_names = .{
        .initiating = "initiating",
        .initiating_request = "initiatingRequest",
        .pending_acceptance = "pendingAcceptance",
        .rolling_back = "rollingBack",
        .pending = "pending",
        .available = "available",
        .modifying = "modifying",
        .deleting = "deleting",
        .deleted = "deleted",
        .failed = "failed",
        .rejected = "rejected",
        .rejecting = "rejecting",
        .failing = "failing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiating => "initiating",
            .initiating_request => "initiatingRequest",
            .pending_acceptance => "pendingAcceptance",
            .rolling_back => "rollingBack",
            .pending => "pending",
            .available => "available",
            .modifying => "modifying",
            .deleting => "deleting",
            .deleted => "deleted",
            .failed => "failed",
            .rejected => "rejected",
            .rejecting => "rejecting",
            .failing => "failing",
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
