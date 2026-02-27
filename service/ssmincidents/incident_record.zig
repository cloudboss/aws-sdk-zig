const AutomationExecution = @import("automation_execution.zig").AutomationExecution;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const IncidentRecordSource = @import("incident_record_source.zig").IncidentRecordSource;
const NotificationTargetItem = @import("notification_target_item.zig").NotificationTargetItem;
const IncidentRecordStatus = @import("incident_record_status.zig").IncidentRecordStatus;

/// The record of the incident that's created when an incident occurs.
pub const IncidentRecord = struct {
    /// The Amazon Resource Name (ARN) of the incident record.
    arn: []const u8,

    /// The runbook, or automation document, that's run at the beginning of the
    /// incident.
    automation_executions: ?[]const AutomationExecution,

    /// The chat channel used for collaboration during an incident.
    chat_channel: ?ChatChannel,

    /// The timestamp for when Incident Manager created the incident record.
    creation_time: i64,

    /// The string Incident Manager uses to prevent duplicate incidents from being
    /// created by the same
    /// incident in the same account.
    dedupe_string: []const u8,

    /// The impact of the incident on customers and applications.
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

    /// Details about the action that started the incident.
    incident_record_source: IncidentRecordSource,

    /// Who modified the incident most recently.
    last_modified_by: []const u8,

    /// The timestamp for when the incident was most recently modified.
    last_modified_time: i64,

    /// The Amazon SNS targets that are notified when updates are made to an
    /// incident.
    notification_targets: ?[]const NotificationTargetItem,

    /// The timestamp for when the incident was resolved. This appears as a timeline
    /// event.
    resolved_time: ?i64,

    /// The current status of the incident.
    status: IncidentRecordStatus,

    /// The summary of the incident. The summary is a brief synopsis of what
    /// occurred, what's
    /// currently happening, and context of the incident.
    summary: ?[]const u8,

    /// The title of the incident.
    title: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .automation_executions = "automationExecutions",
        .chat_channel = "chatChannel",
        .creation_time = "creationTime",
        .dedupe_string = "dedupeString",
        .impact = "impact",
        .incident_record_source = "incidentRecordSource",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .notification_targets = "notificationTargets",
        .resolved_time = "resolvedTime",
        .status = "status",
        .summary = "summary",
        .title = "title",
    };
};
