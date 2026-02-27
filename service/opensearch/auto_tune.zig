const AutoTuneDetails = @import("auto_tune_details.zig").AutoTuneDetails;
const AutoTuneType = @import("auto_tune_type.zig").AutoTuneType;

/// Information about an Auto-Tune action. For more information, see [Auto-Tune
/// for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const AutoTune = struct {
    /// Details about an Auto-Tune action.
    auto_tune_details: ?AutoTuneDetails,

    /// The type of Auto-Tune action.
    auto_tune_type: ?AutoTuneType,

    pub const json_field_names = .{
        .auto_tune_details = "AutoTuneDetails",
        .auto_tune_type = "AutoTuneType",
    };
};
