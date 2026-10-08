const ResourceDiscoveryErrorCode = @import("resource_discovery_error_code.zig").ResourceDiscoveryErrorCode;
const ResourceDiscoveryRunStatus = @import("resource_discovery_run_status.zig").ResourceDiscoveryRunStatus;

/// Contains the status of resource discovery for a service.
pub const ResourceDiscoveryStatus = struct {
    /// The error code if resource discovery failed.
    error_code: ?ResourceDiscoveryErrorCode = null,

    /// A message describing the error if resource discovery failed.
    error_message: ?[]const u8 = null,

    /// The timestamp of the last resource discovery run.
    last_run_at: ?i64 = null,

    /// The current status of resource discovery.
    status: ?ResourceDiscoveryRunStatus = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .last_run_at = "lastRunAt",
        .status = "status",
    };
};
