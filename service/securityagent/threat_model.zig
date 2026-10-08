const Assets = @import("assets.zig").Assets;
const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const DocumentInfo = @import("document_info.zig").DocumentInfo;

/// Represents a threat model configuration that defines the parameters for
/// automated threat analysis, including target assets and logging
/// configuration.
pub const ThreatModel = struct {
    /// The unique identifier of the agent space that contains the threat model.
    agent_space_id: []const u8,

    /// The assets included in the threat model.
    assets: Assets,

    /// The date and time the threat model was created, in UTC format.
    created_at: ?i64 = null,

    /// A description of the application or system being threat modeled.
    description: ?[]const u8 = null,

    /// The CloudWatch Logs configuration for the threat model.
    log_config: ?CloudWatchLog = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The scoped documents for the agent to focus on during threat modeling.
    scope_docs: ?[]const DocumentInfo = null,

    /// The IAM service role used for the threat model.
    service_role: ?[]const u8 = null,

    /// The unique identifier of the threat model.
    threat_model_id: []const u8,

    /// The title of the threat model.
    title: []const u8,

    /// The date and time the threat model was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .created_at = "createdAt",
        .description = "description",
        .log_config = "logConfig",
        .report_destination = "reportDestination",
        .scope_docs = "scopeDocs",
        .service_role = "serviceRole",
        .threat_model_id = "threatModelId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
