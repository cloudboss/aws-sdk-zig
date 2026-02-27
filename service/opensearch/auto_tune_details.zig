const ScheduledAutoTuneDetails = @import("scheduled_auto_tune_details.zig").ScheduledAutoTuneDetails;

/// Specifies details about a scheduled Auto-Tune action. For more information,
/// see [Auto-Tune for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const AutoTuneDetails = struct {
    /// Container for details about a scheduled Auto-Tune action.
    scheduled_auto_tune_details: ?ScheduledAutoTuneDetails,

    pub const json_field_names = .{
        .scheduled_auto_tune_details = "ScheduledAutoTuneDetails",
    };
};
