const Scte35SpliceInsertNoRegionalBlackoutBehavior = @import("scte_35_splice_insert_no_regional_blackout_behavior.zig").Scte35SpliceInsertNoRegionalBlackoutBehavior;
const Scte35SpliceInsertWebDeliveryAllowedBehavior = @import("scte_35_splice_insert_web_delivery_allowed_behavior.zig").Scte35SpliceInsertWebDeliveryAllowedBehavior;

/// Typical configuration that applies breaks on splice inserts in addition to
/// time signal placement opportunities, breaks, and advertisements.
pub const Scte35SpliceInsert = struct {
    /// When specified, this offset (in milliseconds) is added to the input Ad Avail
    /// PTS time. This only applies to embedded SCTE 104/35 messages and does not
    /// apply to OOB messages.
    ad_avail_offset: ?i32,

    /// When set to ignore, Segment Descriptors with noRegionalBlackoutFlag set to 0
    /// will no longer trigger blackouts or Ad Avail slates
    no_regional_blackout_flag: ?Scte35SpliceInsertNoRegionalBlackoutBehavior,

    /// When set to ignore, Segment Descriptors with webDeliveryAllowedFlag set to 0
    /// will no longer trigger blackouts or Ad Avail slates
    web_delivery_allowed_flag: ?Scte35SpliceInsertWebDeliveryAllowedBehavior,

    pub const json_field_names = .{
        .ad_avail_offset = "AdAvailOffset",
        .no_regional_blackout_flag = "NoRegionalBlackoutFlag",
        .web_delivery_allowed_flag = "WebDeliveryAllowedFlag",
    };
};
