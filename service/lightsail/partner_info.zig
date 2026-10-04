const PartnerStatus = @import("partner_status.zig").PartnerStatus;
const TierName = @import("tier_name.zig").TierName;

/// An object that contains information about the Lightsail partner program
/// membership of an
/// Amazon Lightsail account.
pub const PartnerInfo = struct {
    /// The timestamp when the account was enrolled in the Lightsail partner
    /// program.
    enrolled_at: i64,

    /// The status of the partner membership.
    ///
    /// The following statuses are possible:
    ///
    /// * `Active` – The membership is active, and the benefits of the current tier
    /// are available to the account.
    ///
    /// * `Suspended` – The membership is suspended, and the benefits of the tier
    ///   are
    /// not available to the account.
    status: PartnerStatus,

    /// The tier of the partner membership.
    tier_name: ?TierName = null,

    pub const json_field_names = .{
        .enrolled_at = "enrolledAt",
        .status = "status",
        .tier_name = "tierName",
    };
};
