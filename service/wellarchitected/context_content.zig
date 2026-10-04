const ApplicationType = @import("application_type.zig").ApplicationType;
const Criticality = @import("criticality.zig").Criticality;
const ContextResourceTag = @import("context_resource_tag.zig").ContextResourceTag;

/// Typed content structure for a context. Contains application-specific fields
/// that describe the environment used during recommendation generation.
pub const ContextContent = struct {
    /// The Amazon Web Services account IDs associated with this application
    /// context.
    account_ids: ?[]const []const u8 = null,

    /// Additional context not captured by other fields.
    additional_context: ?[]const u8 = null,

    /// A free-form overview of the application.
    application_overview: ?[]const u8 = null,

    /// The type of the application.
    application_type: ?ApplicationType = null,

    /// A free-form description of the application architecture.
    architecture_overview: ?[]const u8 = null,

    /// The Amazon Web Services services used by this application.
    aws_services: ?[]const []const u8 = null,

    /// The business criticality of the application.
    criticality: ?Criticality = null,

    /// The industry vertical for this application.
    industry: ?[]const u8 = null,

    /// The Amazon Web Services Regions where this application operates.
    regions: ?[]const []const u8 = null,

    /// Resource tags used to scope this application context.
    resource_tags: ?[]const ContextResourceTag = null,

    /// The Amazon Web Services resource types relevant to this application.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .additional_context = "additionalContext",
        .application_overview = "applicationOverview",
        .application_type = "applicationType",
        .architecture_overview = "architectureOverview",
        .aws_services = "awsServices",
        .criticality = "criticality",
        .industry = "industry",
        .regions = "regions",
        .resource_tags = "resourceTags",
        .resource_types = "resourceTypes",
    };
};
