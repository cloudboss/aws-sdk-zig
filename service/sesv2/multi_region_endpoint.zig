const Status = @import("status.zig").Status;

/// An object that contains multi-region endpoint (global-endpoint) properties.
pub const MultiRegionEndpoint = struct {
    /// The time stamp of when the multi-region endpoint (global-endpoint) was
    /// created.
    created_timestamp: ?i64 = null,

    /// The ID of the multi-region endpoint (global-endpoint).
    endpoint_id: ?[]const u8 = null,

    /// The name of the multi-region endpoint (global-endpoint).
    endpoint_name: ?[]const u8 = null,

    /// The time stamp of when the multi-region endpoint (global-endpoint) was last
    /// updated.
    last_updated_timestamp: ?i64 = null,

    /// Primary and secondary regions between which multi-region endpoint splits
    /// sending traffic.
    regions: ?[]const []const u8 = null,

    /// The status of the multi-region endpoint (global-endpoint).
    ///
    /// * `CREATING` – The resource is being provisioned.
    ///
    /// * `READY` – The resource is ready to use.
    ///
    /// * `FAILED` – The resource failed to be provisioned.
    ///
    /// * `DELETING` – The resource is being deleted as requested.
    status: ?Status = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .endpoint_id = "EndpointId",
        .endpoint_name = "EndpointName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .regions = "Regions",
        .status = "Status",
    };
};
