const LaunchStatus = @import("launch_status.zig").LaunchStatus;
const ParticipatingResourceID = @import("participating_resource_id.zig").ParticipatingResourceID;

/// Represents a resource participating in an asynchronous Job.
pub const ParticipatingResource = struct {
    /// The launch status of a participating resource.
    launch_status: ?LaunchStatus,

    /// The ID of a participating resource.
    participating_resource_id: ?ParticipatingResourceID,

    pub const json_field_names = .{
        .launch_status = "launchStatus",
        .participating_resource_id = "participatingResourceID",
    };
};
