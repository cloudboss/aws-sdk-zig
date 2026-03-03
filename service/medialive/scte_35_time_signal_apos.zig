const Scte35AposNoRegionalBlackoutBehavior = @import("scte_35_apos_no_regional_blackout_behavior.zig").Scte35AposNoRegionalBlackoutBehavior;
const Scte35AposWebDeliveryAllowedBehavior = @import("scte_35_apos_web_delivery_allowed_behavior.zig").Scte35AposWebDeliveryAllowedBehavior;

/// Atypical configuration that applies segment breaks only on SCTE-35 time
/// signal placement opportunities and breaks.
pub const Scte35TimeSignalApos = struct {
    /// When specified, this offset (in milliseconds) is added to the input Ad Avail
    /// PTS time. This only applies to embedded SCTE 104/35 messages and does not
    /// apply to OOB messages.
    ad_avail_offset: ?i32 = null,

    /// When set to ignore, Segment Descriptors with noRegionalBlackoutFlag set to 0
    /// will no longer trigger blackouts or Ad Avail slates
    no_regional_blackout_flag: ?Scte35AposNoRegionalBlackoutBehavior = null,

    /// When set to ignore, Segment Descriptors with webDeliveryAllowedFlag set to 0
    /// will no longer trigger blackouts or Ad Avail slates
    web_delivery_allowed_flag: ?Scte35AposWebDeliveryAllowedBehavior = null,

    pub const json_field_names = .{
        .ad_avail_offset = "AdAvailOffset",
        .no_regional_blackout_flag = "NoRegionalBlackoutFlag",
        .web_delivery_allowed_flag = "WebDeliveryAllowedFlag",
    };
};
