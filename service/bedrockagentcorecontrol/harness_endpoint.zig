const HarnessEndpointStatus = @import("harness_endpoint_status.zig").HarnessEndpointStatus;

/// Representation of a harness endpoint. An endpoint is a named, stable
/// reference to a specific version of a harness that callers invoke, allowing
/// the underlying version to be updated without changing how the agent is
/// invoked.
pub const HarnessEndpoint = struct {
    /// The ARN of the endpoint.
    arn: []const u8,

    /// The timestamp when the endpoint was created.
    created_at: i64,

    /// The description of the endpoint.
    description: ?[]const u8 = null,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    /// The reason the endpoint's last create or update operation failed.
    failure_reason: ?[]const u8 = null,

    /// The ID of the harness that the endpoint belongs to.
    harness_id: []const u8,

    /// The name of the harness that the endpoint belongs to.
    harness_name: []const u8,

    /// The harness version that the endpoint is currently serving.
    live_version: ?[]const u8 = null,

    /// The status of the endpoint.
    status: HarnessEndpointStatus,

    /// The harness version that the endpoint points to. While an update is in
    /// progress, this can differ from the live version until the endpoint finishes
    /// transitioning.
    target_version: ?[]const u8 = null,

    /// The timestamp when the endpoint was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .endpoint_name = "endpointName",
        .failure_reason = "failureReason",
        .harness_id = "harnessId",
        .harness_name = "harnessName",
        .live_version = "liveVersion",
        .status = "status",
        .target_version = "targetVersion",
        .updated_at = "updatedAt",
    };
};
