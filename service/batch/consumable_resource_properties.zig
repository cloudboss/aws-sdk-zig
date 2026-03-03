const ConsumableResourceRequirement = @import("consumable_resource_requirement.zig").ConsumableResourceRequirement;

/// Contains a list of consumable resources required by a job.
pub const ConsumableResourceProperties = struct {
    /// The list of consumable resources required by a job.
    consumable_resource_list: ?[]const ConsumableResourceRequirement = null,

    pub const json_field_names = .{
        .consumable_resource_list = "consumableResourceList",
    };
};
