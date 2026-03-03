const std = @import("std");

pub const stateType = enum {
    unassigned,
    assigned,
    pending_approval,
    finalized,
    accepted,
    rejected,
    expired,

    pub const json_field_names = .{
        .unassigned = "UNASSIGNED",
        .assigned = "ASSIGNED",
        .pending_approval = "PENDING_APPROVAL",
        .finalized = "FINALIZED",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unassigned => "UNASSIGNED",
            .assigned => "ASSIGNED",
            .pending_approval => "PENDING_APPROVAL",
            .finalized => "FINALIZED",
            .accepted => "ACCEPTED",
            .rejected => "REJECTED",
            .expired => "EXPIRED",
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
