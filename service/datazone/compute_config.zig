/// The compute configuration for a notebook run in Amazon DataZone.
pub const ComputeConfig = struct {
    /// The environment version for the notebook run compute.
    environment_version: ?[]const u8 = null,

    /// The instance type for the notebook run compute.
    instance_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_version = "environmentVersion",
        .instance_type = "instanceType",
    };
};
