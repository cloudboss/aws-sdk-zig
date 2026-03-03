const ImportTaskSummaryApplications = @import("import_task_summary_applications.zig").ImportTaskSummaryApplications;
const ImportTaskSummaryServers = @import("import_task_summary_servers.zig").ImportTaskSummaryServers;
const ImportTaskSummaryWaves = @import("import_task_summary_waves.zig").ImportTaskSummaryWaves;

/// Import task summary.
pub const ImportTaskSummary = struct {
    /// Import task summary applications.
    applications: ?ImportTaskSummaryApplications = null,

    /// Import task summary servers.
    servers: ?ImportTaskSummaryServers = null,

    /// Import task summary waves.
    waves: ?ImportTaskSummaryWaves = null,

    pub const json_field_names = .{
        .applications = "applications",
        .servers = "servers",
        .waves = "waves",
    };
};
