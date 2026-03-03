const ReferenceDetails = @import("reference_details.zig").ReferenceDetails;

/// The reference (threshold) for a metric.
pub const MetricReference = struct {
    /// The name of the metric reference.
    name: ?[]const u8 = null,

    /// The details of a performance issue.
    reference_details: ?ReferenceDetails = null,
};
