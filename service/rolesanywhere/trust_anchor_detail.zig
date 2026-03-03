const NotificationSettingDetail = @import("notification_setting_detail.zig").NotificationSettingDetail;
const Source = @import("source.zig").Source;

/// The state of the trust anchor after a read or write operation.
pub const TrustAnchorDetail = struct {
    /// The ISO-8601 timestamp when the trust anchor was created.
    created_at: ?i64 = null,

    /// Indicates whether the trust anchor is enabled.
    enabled: ?bool = null,

    /// The name of the trust anchor.
    name: ?[]const u8 = null,

    /// A list of notification settings to be associated to the trust anchor.
    notification_settings: ?[]const NotificationSettingDetail = null,

    /// The trust anchor type and its related certificate data.
    source: ?Source = null,

    /// The ARN of the trust anchor.
    trust_anchor_arn: ?[]const u8 = null,

    /// The unique identifier of the trust anchor.
    trust_anchor_id: ?[]const u8 = null,

    /// The ISO-8601 timestamp when the trust anchor was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .enabled = "enabled",
        .name = "name",
        .notification_settings = "notificationSettings",
        .source = "source",
        .trust_anchor_arn = "trustAnchorArn",
        .trust_anchor_id = "trustAnchorId",
        .updated_at = "updatedAt",
    };
};
