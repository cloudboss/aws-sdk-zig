const aws = @import("aws");

const AlarmType = @import("alarm_type.zig").AlarmType;
const HistoryItemType = @import("history_item_type.zig").HistoryItemType;

/// Represents the history of a specific alarm.
pub const AlarmHistoryItem = struct {
    /// A map of attributes that describe the alarm contributor associated with this
    /// history item, providing context about the contributor's characteristics at
    /// the time of the event.
    alarm_contributor_attributes: ?[]const aws.map.StringMapEntry,

    /// The unique identifier of the alarm contributor associated with this history
    /// item, if applicable.
    alarm_contributor_id: ?[]const u8,

    /// The descriptive name for the alarm.
    alarm_name: ?[]const u8,

    /// The type of alarm, either metric alarm or composite alarm.
    alarm_type: ?AlarmType,

    /// Data about the alarm, in JSON format.
    history_data: ?[]const u8,

    /// The type of alarm history item.
    history_item_type: ?HistoryItemType,

    /// A summary of the alarm history, in text format.
    history_summary: ?[]const u8,

    /// The time stamp for the alarm history item.
    timestamp: ?i64,

    pub const json_field_names = .{
        .alarm_contributor_attributes = "AlarmContributorAttributes",
        .alarm_contributor_id = "AlarmContributorId",
        .alarm_name = "AlarmName",
        .alarm_type = "AlarmType",
        .history_data = "HistoryData",
        .history_item_type = "HistoryItemType",
        .history_summary = "HistorySummary",
        .timestamp = "Timestamp",
    };
};
