const LifeCycleLastLaunchInitiated = @import("life_cycle_last_launch_initiated.zig").LifeCycleLastLaunchInitiated;
const LaunchStatus = @import("launch_status.zig").LaunchStatus;

/// An object containing information regarding the last launch of a Source
/// Server.
pub const LifeCycleLastLaunch = struct {
    /// An object containing information regarding the initiation of the last launch
    /// of a Source Server.
    initiated: ?LifeCycleLastLaunchInitiated,

    /// Status of Source Server's last launch.
    status: ?LaunchStatus,

    pub const json_field_names = .{
        .initiated = "initiated",
        .status = "status",
    };
};
