const SourceCampaign = @import("source_campaign.zig").SourceCampaign;

/// The source of an outbound web notification. Identifies the campaign and
/// outbound request that triggered the
/// notification.
pub const WebNotificationSource = struct {
    /// Information about the campaign that triggered the web notification,
    /// including the campaign identifier and
    /// outbound request identifier.
    source_campaign: SourceCampaign,

    pub const json_field_names = .{
        .source_campaign = "SourceCampaign",
    };
};
