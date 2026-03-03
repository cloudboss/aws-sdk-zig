const aws = @import("aws");

const NotificationTargetItem = @import("notification_target_item.zig").NotificationTargetItem;

/// Basic details used in creating a response plan. The response plan is then
/// used to create
/// an incident record.
pub const IncidentTemplate = struct {
    /// The string Incident Manager uses to prevent the same root cause from
    /// creating multiple
    /// incidents in the same account.
    ///
    /// A deduplication string is a term or phrase the system uses to check for
    /// duplicate
    /// incidents. If you specify a deduplication string, Incident Manager searches
    /// for open incidents that
    /// contain the same string in the `dedupeString` field when it creates the
    /// incident.
    /// If a duplicate is detected, Incident Manager deduplicates the newer incident
    /// into the existing
    /// incident.
    ///
    /// By default, Incident Manager automatically deduplicates multiple incidents
    /// created by the
    /// same Amazon CloudWatch alarm or Amazon EventBridge event. You don't have to
    /// enter
    /// your own deduplication string to prevent duplication for these resource
    /// types.
    dedupe_string: ?[]const u8 = null,

    /// The impact of the incident on your customers and applications.
    ///
    /// **Supported impact codes**
    ///
    /// * `1` - Critical
    ///
    /// * `2` - High
    ///
    /// * `3` - Medium
    ///
    /// * `4` - Low
    ///
    /// * `5` - No Impact
    impact: i32,

    /// Tags to assign to the template. When the `StartIncident` API action is
    /// called,
    /// Incident Manager assigns the tags specified in the template to the incident.
    incident_tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon SNS targets that are notified when updates are made to an
    /// incident.
    notification_targets: ?[]const NotificationTargetItem = null,

    /// The summary of the incident. The summary is a brief synopsis of what
    /// occurred, what's
    /// currently happening, and context.
    summary: ?[]const u8 = null,

    /// The title of the incident.
    title: []const u8,

    pub const json_field_names = .{
        .dedupe_string = "dedupeString",
        .impact = "impact",
        .incident_tags = "incidentTags",
        .notification_targets = "notificationTargets",
        .summary = "summary",
        .title = "title",
    };
};
