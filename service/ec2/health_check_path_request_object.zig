const HealthCheckPathDestinationRequestObject = @import("health_check_path_destination_request_object.zig").HealthCheckPathDestinationRequestObject;
const HealthCheckPathSourceRequestObject = @import("health_check_path_source_request_object.zig").HealthCheckPathSourceRequestObject;

/// Describes a health check path for an application status check request.
pub const HealthCheckPathRequestObject = struct {
    /// The destinations for the health check path.
    destinations: ?[]const HealthCheckPathDestinationRequestObject = null,

    /// The source for the health check path.
    source: ?HealthCheckPathSourceRequestObject = null,
};
