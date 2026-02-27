const Commitment = @import("commitment.zig").Commitment;
const RenewalType = @import("renewal_type.zig").RenewalType;

/// Details about the pricing plan for your reserved queue. Required for
/// reserved queues and not applicable to on-demand queues.
pub const ReservationPlanSettings = struct {
    /// The length of the term of your reserved queue pricing plan commitment.
    commitment: Commitment,

    /// Specifies whether the term of your reserved queue pricing plan is
    /// automatically extended (AUTO_RENEW) or expires (EXPIRE) at the end of the
    /// term. When your term is auto renewed, you extend your commitment by 12
    /// months from the auto renew date. You can cancel this commitment.
    renewal_type: RenewalType,

    /// Specifies the number of reserved transcode slots (RTS) for this queue. The
    /// number of RTS determines how many jobs the queue can process in parallel;
    /// each RTS can process one job at a time. You can't decrease the number of RTS
    /// in your reserved queue. You can increase the number of RTS by extending your
    /// existing commitment with a new 12-month commitment for the larger number.
    /// The new commitment begins when you purchase the additional capacity. You
    /// can't cancel your commitment or revert to your original commitment after you
    /// increase the capacity.
    reserved_slots: i32,

    pub const json_field_names = .{
        .commitment = "Commitment",
        .renewal_type = "RenewalType",
        .reserved_slots = "ReservedSlots",
    };
};
