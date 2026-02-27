const AutoScalingSettings = @import("auto_scaling_settings.zig").AutoScalingSettings;

/// The Amazon Web Services Region specific settings of a multi-Region table.
///
/// For a multi-Region table, you can configure the table's read capacity
/// differently per Amazon Web Services Region. You can do this by configuring
/// the following parameters.
///
/// * `region`: The Region where these settings are applied. (Required)
/// * `readCapacityUnits`: The provisioned read capacity units. (Optional)
/// * `readCapacityAutoScaling`: The read capacity auto scaling settings for the
///   table. (Optional)
pub const ReplicaSpecification = struct {
    /// The read capacity auto scaling settings for the multi-Region table in the
    /// specified Amazon Web Services Region.
    read_capacity_auto_scaling: ?AutoScalingSettings,

    /// The provisioned read capacity units for the multi-Region table in the
    /// specified Amazon Web Services Region.
    read_capacity_units: ?i64,

    /// The Amazon Web Services Region.
    region: []const u8,

    pub const json_field_names = .{
        .read_capacity_auto_scaling = "readCapacityAutoScaling",
        .read_capacity_units = "readCapacityUnits",
        .region = "region",
    };
};
