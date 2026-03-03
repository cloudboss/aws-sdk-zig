const OpenSearchResourceStatus = @import("open_search_resource_status.zig").OpenSearchResourceStatus;

/// This structure contains information about the OpenSearch Service workspace
/// used for this
/// integration. An OpenSearch Service workspace is the collection of dashboards
/// along with other
/// OpenSearch Service tools. This workspace was created automatically as part
/// of the
/// integration setup. For more information, see [Centralized OpenSearch user
/// interface (Dashboards) with OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/application.html).
pub const OpenSearchWorkspace = struct {
    /// This structure contains information about the status of an OpenSearch
    /// Service
    /// resource.
    status: ?OpenSearchResourceStatus = null,

    /// The ID of this workspace.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .workspace_id = "workspaceId",
    };
};
