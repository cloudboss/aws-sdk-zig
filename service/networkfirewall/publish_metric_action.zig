const Dimension = @import("dimension.zig").Dimension;

/// Stateless inspection criteria that publishes the specified metrics to Amazon
/// CloudWatch for the
/// matching packet. This setting defines a CloudWatch dimension value to be
/// published.
pub const PublishMetricAction = struct {
    dimensions: []const Dimension,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
    };
};
