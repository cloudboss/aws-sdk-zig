const std = @import("std");

/// Lifecycle status of an approval request, distinct from the action verb.
/// State machine: PENDING (awaiting a decision) -> APPROVED (the action was
/// APPROVED; redeemable until revoked or fully redeemed) or REJECTED (the
/// action was REJECTED; terminal). APPROVED -> REDEEMED (consumed by a
/// credential mint at least once; non-single-use approvals stay re-redeemable
/// until expiry) or REVOKED (administratively invalidated; terminal).
pub const ApprovalStatus = enum {
    /// The approval request is awaiting a decision.
    pending,
    /// The action was APPROVED; the approval request is live and may be redeemed
    /// via a credential mint until it is revoked or fully redeemed.
    approved,
    /// The action was REJECTED; no further redemption is possible.
    rejected,
    /// The approval was administratively invalidated; no further redemption is
    /// possible.
    revoked,
    /// The approval was consumed by a credential mint at least once. Non-single-use
    /// approvals stay re-redeemable until expiry; single-use approvals are
    /// terminal.
    redeemed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .revoked = "REVOKED",
        .redeemed = "REDEEMED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .approved => "APPROVED",
            .rejected => "REJECTED",
            .revoked => "REVOKED",
            .redeemed => "REDEEMED",
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
