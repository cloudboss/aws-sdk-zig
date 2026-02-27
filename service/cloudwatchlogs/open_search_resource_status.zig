const OpenSearchResourceStatusType = @import("open_search_resource_status_type.zig").OpenSearchResourceStatusType;

/// This structure contains information about the status of an OpenSearch
/// Service
/// resource.
pub const OpenSearchResourceStatus = struct {
    /// The current status of this resource.
    status: ?OpenSearchResourceStatusType,

    /// A message with additional information about the status of this resource.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .status = "status",
        .status_message = "statusMessage",
    };
};
