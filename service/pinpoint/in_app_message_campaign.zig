const InAppMessage = @import("in_app_message.zig").InAppMessage;
const InAppCampaignSchedule = @import("in_app_campaign_schedule.zig").InAppCampaignSchedule;

/// Targeted in-app message campaign.
pub const InAppMessageCampaign = struct {
    /// Campaign id of the corresponding campaign.
    campaign_id: ?[]const u8 = null,

    /// Daily cap which controls the number of times any in-app messages can be
    /// shown to the endpoint during a day.
    daily_cap: ?i32 = null,

    /// In-app message content with all fields required for rendering an in-app
    /// message.
    in_app_message: ?InAppMessage = null,

    /// Priority of the in-app message.
    priority: ?i32 = null,

    /// Schedule of the campaign.
    schedule: ?InAppCampaignSchedule = null,

    /// Session cap which controls the number of times an in-app message can be
    /// shown to the endpoint during an application session.
    session_cap: ?i32 = null,

    /// Total cap which controls the number of times an in-app message can be shown
    /// to the endpoint.
    total_cap: ?i32 = null,

    /// Treatment id of the campaign.
    treatment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_id = "CampaignId",
        .daily_cap = "DailyCap",
        .in_app_message = "InAppMessage",
        .priority = "Priority",
        .schedule = "Schedule",
        .session_cap = "SessionCap",
        .total_cap = "TotalCap",
        .treatment_id = "TreatmentId",
    };
};
