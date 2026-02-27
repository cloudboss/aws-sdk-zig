/// Describes a no bid action.
pub const NoBidAction = struct {
    /// The reason code for the no bid action.
    no_bid_reason_code: ?i32,

    pub const json_field_names = .{
        .no_bid_reason_code = "noBidReasonCode",
    };
};
