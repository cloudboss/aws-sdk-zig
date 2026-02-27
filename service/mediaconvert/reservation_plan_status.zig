/// Specifies whether the pricing plan for your reserved queue is ACTIVE or
/// EXPIRED.
pub const ReservationPlanStatus = enum {
    active,
    expired,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .expired = "EXPIRED",
    };
};
