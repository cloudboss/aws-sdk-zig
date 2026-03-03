const LongTermPricingType = @import("long_term_pricing_type.zig").LongTermPricingType;
const SnowballType = @import("snowball_type.zig").SnowballType;

/// Each `LongTermPricingListEntry` object contains information about a
/// long-term
/// pricing type.
pub const LongTermPricingListEntry = struct {
    /// The current active jobs on the device the long-term pricing type.
    current_active_job: ?[]const u8 = null,

    /// If set to `true`, specifies that the current long-term pricing type for the
    /// device should be automatically renewed before the long-term pricing contract
    /// expires.
    is_long_term_pricing_auto_renew: ?bool = null,

    /// The IDs of the jobs that are associated with a long-term pricing type.
    job_ids: ?[]const []const u8 = null,

    /// The end date the long-term pricing contract.
    long_term_pricing_end_date: ?i64 = null,

    /// The ID of the long-term pricing type for the device.
    long_term_pricing_id: ?[]const u8 = null,

    /// The start date of the long-term pricing contract.
    long_term_pricing_start_date: ?i64 = null,

    /// The status of the long-term pricing type.
    long_term_pricing_status: ?[]const u8 = null,

    /// The type of long-term pricing that was selected for the device.
    long_term_pricing_type: ?LongTermPricingType = null,

    /// A new device that replaces a device that is ordered with long-term pricing.
    replacement_job: ?[]const u8 = null,

    /// The type of Snow Family devices associated with this long-term pricing job.
    snowball_type: ?SnowballType = null,

    pub const json_field_names = .{
        .current_active_job = "CurrentActiveJob",
        .is_long_term_pricing_auto_renew = "IsLongTermPricingAutoRenew",
        .job_ids = "JobIds",
        .long_term_pricing_end_date = "LongTermPricingEndDate",
        .long_term_pricing_id = "LongTermPricingId",
        .long_term_pricing_start_date = "LongTermPricingStartDate",
        .long_term_pricing_status = "LongTermPricingStatus",
        .long_term_pricing_type = "LongTermPricingType",
        .replacement_job = "ReplacementJob",
        .snowball_type = "SnowballType",
    };
};
