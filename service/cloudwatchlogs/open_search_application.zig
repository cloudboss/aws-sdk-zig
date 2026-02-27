const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service application
/// used for this
/// integration. An OpenSearch Service application is the web application
/// created by the
/// integration with CloudWatch Logs. It hosts the vended logs dashboards.
pub const OpenSearchApplication = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8,

    /// The endpoint of the application.
    application_endpoint: ?[]const u8,

    /// The ID of the application.
    application_id: ?[]const u8,

    /// This structure contains information about the status of this OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .application_endpoint = "applicationEndpoint",
        .application_id = "applicationId",
        .status = "status",
    };
};
