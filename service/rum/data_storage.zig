const CwLog = @import("cw_log.zig").CwLog;

/// A structure that contains information about whether this app monitor stores
/// a copy of the telemetry data that RUM collects using CloudWatch Logs.
pub const DataStorage = struct {
    /// A structure that contains the information about whether the app monitor
    /// stores copies of the data that RUM collects in CloudWatch Logs. If it does,
    /// this structure also contains the name of the log group.
    cw_log: ?CwLog,

    pub const json_field_names = .{
        .cw_log = "CwLog",
    };
};
