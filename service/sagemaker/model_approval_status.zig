const std = @import("std");

pub const ModelApprovalStatus = enum {
    approved,
    rejected,
    pending_manual_approval,

    pub const json_field_names = .{
        .approved = "Approved",
        .rejected = "Rejected",
        .pending_manual_approval = "PendingManualApproval",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approved => "Approved",
            .rejected => "Rejected",
            .pending_manual_approval => "PendingManualApproval",
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
