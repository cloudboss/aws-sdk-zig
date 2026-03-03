const std = @import("std");

pub const State = enum {
    pending_acceptance,
    pending,
    available,
    deleting,
    deleted,
    rejected,
    failed,
    expired,
    partial,

    pub const json_field_names = .{
        .pending_acceptance = "PendingAcceptance",
        .pending = "Pending",
        .available = "Available",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .rejected = "Rejected",
        .failed = "Failed",
        .expired = "Expired",
        .partial = "Partial",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_acceptance => "PendingAcceptance",
            .pending => "Pending",
            .available => "Available",
            .deleting => "Deleting",
            .deleted => "Deleted",
            .rejected => "Rejected",
            .failed => "Failed",
            .expired => "Expired",
            .partial => "Partial",
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
