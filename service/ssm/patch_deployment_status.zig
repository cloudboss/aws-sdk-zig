const std = @import("std");

pub const PatchDeploymentStatus = enum {
    approved,
    pending_approval,
    explicit_approved,
    explicit_rejected,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .pending_approval = "PENDING_APPROVAL",
        .explicit_approved = "EXPLICIT_APPROVED",
        .explicit_rejected = "EXPLICIT_REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approved => "APPROVED",
            .pending_approval => "PENDING_APPROVAL",
            .explicit_approved => "EXPLICIT_APPROVED",
            .explicit_rejected => "EXPLICIT_REJECTED",
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
