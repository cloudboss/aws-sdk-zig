const ScheduledAutoTuneDetails = @import("scheduled_auto_tune_details.zig").ScheduledAutoTuneDetails;

/// Specifies details of the Auto-Tune action. See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const AutoTuneDetails = struct {
    scheduled_auto_tune_details: ?ScheduledAutoTuneDetails = null,

    pub const json_field_names = .{
        .scheduled_auto_tune_details = "ScheduledAutoTuneDetails",
    };
};
