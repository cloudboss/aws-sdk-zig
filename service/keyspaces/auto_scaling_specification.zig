const AutoScalingSettings = @import("auto_scaling_settings.zig").AutoScalingSettings;

/// The optional auto scaling capacity settings for a table in provisioned
/// capacity mode.
pub const AutoScalingSpecification = struct {
    /// The auto scaling settings for the table's read capacity.
    read_capacity_auto_scaling: ?AutoScalingSettings = null,

    /// The auto scaling settings for the table's write capacity.
    write_capacity_auto_scaling: ?AutoScalingSettings = null,

    pub const json_field_names = .{
        .read_capacity_auto_scaling = "readCapacityAutoScaling",
        .write_capacity_auto_scaling = "writeCapacityAutoScaling",
    };
};
