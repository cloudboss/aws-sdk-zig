const InstanceApplicationStatus = @import("instance_application_status.zig").InstanceApplicationStatus;

/// Describes the application statuses for instances.
pub const ApplicationStatusesResponseType = struct {
    /// The application status information for the instances.
    instances: ?[]const InstanceApplicationStatus = null,
};
