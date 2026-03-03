/// A structure that contains the information about whether the app monitor
/// stores copies of the data that RUM collects in CloudWatch Logs. If it does,
/// this structure also contains the name of the log group.
pub const CwLog = struct {
    /// Indicated whether the app monitor stores copies of the data that RUM
    /// collects in CloudWatch Logs.
    cw_log_enabled: ?bool = null,

    /// The name of the log group where the copies are stored.
    cw_log_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .cw_log_enabled = "CwLogEnabled",
        .cw_log_group = "CwLogGroup",
    };
};
