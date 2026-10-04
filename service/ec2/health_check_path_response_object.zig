const HealthCheckPathDestinationResponseObject = @import("health_check_path_destination_response_object.zig").HealthCheckPathDestinationResponseObject;
const HealthCheckPathSourceResponseObject = @import("health_check_path_source_response_object.zig").HealthCheckPathSourceResponseObject;

/// Describes a health check path for an application status check.
pub const HealthCheckPathResponseObject = struct {
    /// The destinations for the health check path.
    destinations: ?[]const HealthCheckPathDestinationResponseObject = null,

    /// The source for the health check path.
    source: ?HealthCheckPathSourceResponseObject = null,
};
