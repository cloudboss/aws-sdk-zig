const AbortConfigCriteria = @import("abort_config_criteria.zig").AbortConfigCriteria;

/// Over-the-air (OTA) task abort config.
pub const OtaTaskAbortConfig = struct {
    /// The list of criteria for the abort config.
    abort_config_criteria_list: ?[]const AbortConfigCriteria,

    pub const json_field_names = .{
        .abort_config_criteria_list = "AbortConfigCriteriaList",
    };
};
