const AutoTuneDetails = @import("auto_tune_details.zig").AutoTuneDetails;
const AutoTuneType = @import("auto_tune_type.zig").AutoTuneType;

/// Specifies Auto-Tune type and Auto-Tune action details.
pub const AutoTune = struct {
    /// Specifies details of the Auto-Tune action. See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    auto_tune_details: ?AutoTuneDetails = null,

    /// Specifies Auto-Tune type. Valid value is SCHEDULED_ACTION.
    auto_tune_type: ?AutoTuneType = null,

    pub const json_field_names = .{
        .auto_tune_details = "AutoTuneDetails",
        .auto_tune_type = "AutoTuneType",
    };
};
