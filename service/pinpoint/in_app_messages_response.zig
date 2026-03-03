const InAppMessageCampaign = @import("in_app_message_campaign.zig").InAppMessageCampaign;

/// Get in-app messages response object.
pub const InAppMessagesResponse = struct {
    /// List of targeted in-app message campaigns.
    in_app_message_campaigns: ?[]const InAppMessageCampaign = null,

    pub const json_field_names = .{
        .in_app_message_campaigns = "InAppMessageCampaigns",
    };
};
