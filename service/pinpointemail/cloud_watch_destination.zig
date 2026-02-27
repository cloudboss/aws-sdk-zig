const CloudWatchDimensionConfiguration = @import("cloud_watch_dimension_configuration.zig").CloudWatchDimensionConfiguration;

/// An object that defines an Amazon CloudWatch destination for email events.
/// You can use Amazon CloudWatch to
/// monitor and gain insights on your email sending metrics.
pub const CloudWatchDestination = struct {
    /// An array of objects that define the dimensions to use when you send email
    /// events to
    /// Amazon CloudWatch.
    dimension_configurations: []const CloudWatchDimensionConfiguration,

    pub const json_field_names = .{
        .dimension_configurations = "DimensionConfigurations",
    };
};
