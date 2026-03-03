const Commitment = @import("commitment.zig").Commitment;
const RenewalType = @import("renewal_type.zig").RenewalType;
const ReservationPlanStatus = @import("reservation_plan_status.zig").ReservationPlanStatus;

/// Details about the pricing plan for your reserved queue. Required for
/// reserved queues and not applicable to on-demand queues.
pub const ReservationPlan = struct {
    /// The length of the term of your reserved queue pricing plan commitment.
    commitment: ?Commitment = null,

    /// The timestamp in epoch seconds for when the current pricing plan term for
    /// this reserved queue expires.
    expires_at: ?i64 = null,

    /// The timestamp in epoch seconds for when you set up the current pricing plan
    /// for this reserved queue.
    purchased_at: ?i64 = null,

    /// Specifies whether the term of your reserved queue pricing plan is
    /// automatically extended (AUTO_RENEW) or expires (EXPIRE) at the end of the
    /// term.
    renewal_type: ?RenewalType = null,

    /// Specifies the number of reserved transcode slots (RTS) for this queue. The
    /// number of RTS determines how many jobs the queue can process in parallel;
    /// each RTS can process one job at a time. When you increase this number, you
    /// extend your existing commitment with a new 12-month commitment for a larger
    /// number of RTS. The new commitment begins when you purchase the additional
    /// capacity. You can't decrease the number of RTS in your reserved queue.
    reserved_slots: ?i32 = null,

    /// Specifies whether the pricing plan for your reserved queue is ACTIVE or
    /// EXPIRED.
    status: ?ReservationPlanStatus = null,

    pub const json_field_names = .{
        .commitment = "Commitment",
        .expires_at = "ExpiresAt",
        .purchased_at = "PurchasedAt",
        .renewal_type = "RenewalType",
        .reserved_slots = "ReservedSlots",
        .status = "Status",
    };
};
