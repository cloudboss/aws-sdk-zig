const TestSetDiscrepancyReportBotAliasTarget = @import("test_set_discrepancy_report_bot_alias_target.zig").TestSetDiscrepancyReportBotAliasTarget;

/// Contains information about the resource used for the
/// test set discrepancy report.
pub const TestSetDiscrepancyReportResourceTarget = struct {
    /// Contains information about the bot alias used as the resource for the
    /// test set discrepancy report.
    bot_alias_target: ?TestSetDiscrepancyReportBotAliasTarget = null,

    pub const json_field_names = .{
        .bot_alias_target = "botAliasTarget",
    };
};
