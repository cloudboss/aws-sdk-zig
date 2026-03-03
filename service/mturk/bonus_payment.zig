/// An object representing a Bonus payment paid to a Worker.
pub const BonusPayment = struct {
    /// The ID of the assignment associated with this bonus payment.
    assignment_id: ?[]const u8 = null,

    bonus_amount: ?[]const u8 = null,

    /// The date and time of when the bonus was granted.
    grant_time: ?i64 = null,

    /// The Reason text given when the bonus was granted, if any.
    reason: ?[]const u8 = null,

    /// The ID of the Worker to whom the bonus was paid.
    worker_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .bonus_amount = "BonusAmount",
        .grant_time = "GrantTime",
        .reason = "Reason",
        .worker_id = "WorkerId",
    };
};
