const AwsManagedTargetDestination = @import("aws_managed_target_destination.zig").AwsManagedTargetDestination;

/// Object containing the choice of application destination that you specify.
pub const AwsManagedResources = struct {
    /// The choice of application destination that you specify.
    target_destination: []const AwsManagedTargetDestination,

    pub const json_field_names = .{
        .target_destination = "targetDestination",
    };
};
