const ImportTaskSummaryApplications = @import("import_task_summary_applications.zig").ImportTaskSummaryApplications;
const ImportTaskSummaryServers = @import("import_task_summary_servers.zig").ImportTaskSummaryServers;
const ImportTaskSummaryWaves = @import("import_task_summary_waves.zig").ImportTaskSummaryWaves;

/// Import task summary.
pub const ImportTaskSummary = struct {
    /// Import task summary applications.
    applications: ?ImportTaskSummaryApplications,

    /// Import task summary servers.
    servers: ?ImportTaskSummaryServers,

    /// Import task summary waves.
    waves: ?ImportTaskSummaryWaves,

    pub const json_field_names = .{
        .applications = "applications",
        .servers = "servers",
        .waves = "waves",
    };
};
