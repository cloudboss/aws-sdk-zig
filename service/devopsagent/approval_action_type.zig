const std = @import("std");

/// The action to take on an approval request — APPROVED or REJECTED.
pub const ApprovalActionType = enum {
    /// The agent's tool invocation is approved; finalPattern and ttlSeconds carry
    /// the finalized scope and lifetime.
    approved,
    /// The agent's tool invocation is rejected; reason optionally carries a
    /// free-text rationale.
    rejected,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approved => "APPROVED",
            .rejected => "REJECTED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
