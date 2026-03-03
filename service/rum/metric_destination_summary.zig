const MetricDestination = @import("metric_destination.zig").MetricDestination;

/// A structure that displays information about one destination that CloudWatch
/// RUM sends extended metrics to.
pub const MetricDestinationSummary = struct {
    /// Specifies whether the destination is `CloudWatch` or `Evidently`.
    destination: ?MetricDestination = null,

    /// If the destination is `Evidently`, this specifies the ARN of the Evidently
    /// experiment that receives the metrics.
    destination_arn: ?[]const u8 = null,

    /// This field appears only when the destination is `Evidently`. It specifies
    /// the ARN of the IAM role that is used to write to the Evidently experiment
    /// that receives the metrics.
    iam_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .destination_arn = "DestinationArn",
        .iam_role_arn = "IamRoleArn",
    };
};
