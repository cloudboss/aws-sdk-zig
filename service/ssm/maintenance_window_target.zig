const MaintenanceWindowResourceType = @import("maintenance_window_resource_type.zig").MaintenanceWindowResourceType;
const Target = @import("target.zig").Target;

/// The target registered with the maintenance window.
pub const MaintenanceWindowTarget = struct {
    /// A description for the target.
    description: ?[]const u8 = null,

    /// The name for the maintenance window target.
    name: ?[]const u8 = null,

    /// A user-provided value that will be included in any Amazon CloudWatch Events
    /// events that are
    /// raised while running tasks for these targets in this maintenance window.
    owner_information: ?[]const u8 = null,

    /// The type of target that is being registered with the maintenance window.
    resource_type: ?MaintenanceWindowResourceType = null,

    /// The targets, either managed nodes or tags.
    ///
    /// Specify managed nodes using the following format:
    ///
    /// `Key=instanceids,Values=,`
    ///
    /// Tags are specified using the following format:
    ///
    /// `Key=,Values=`.
    targets: ?[]const Target = null,

    /// The ID of the maintenance window to register the target with.
    window_id: ?[]const u8 = null,

    /// The ID of the target.
    window_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .owner_information = "OwnerInformation",
        .resource_type = "ResourceType",
        .targets = "Targets",
        .window_id = "WindowId",
        .window_target_id = "WindowTargetId",
    };
};
