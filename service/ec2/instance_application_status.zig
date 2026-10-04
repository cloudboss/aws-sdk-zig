const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const Tag = @import("tag.zig").Tag;

/// Describes the application status for an instance.
pub const InstanceApplicationStatus = struct {
    /// The application status for the instance.
    application_status: ?ApplicationStatus = null,

    /// The Availability Zone of the instance.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone of the instance.
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The tags assigned to the instance.
    tags: ?[]const Tag = null,
};
