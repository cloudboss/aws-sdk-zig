const SourceCollectionStatus = @import("source_collection_status.zig").SourceCollectionStatus;

/// Retrieves the Logs status for the Amazon Security Lake account.
pub const DataLakeSourceStatus = struct {
    /// Defines path the stored logs are available which has information on your
    /// systems,
    /// applications, and services.
    resource: ?[]const u8 = null,

    /// The health status of services, including error codes and patterns.
    status: ?SourceCollectionStatus = null,

    pub const json_field_names = .{
        .resource = "resource",
        .status = "status",
    };
};
