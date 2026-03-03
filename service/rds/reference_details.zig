const ScalarReferenceDetails = @import("scalar_reference_details.zig").ScalarReferenceDetails;

/// The reference details of a metric.
pub const ReferenceDetails = struct {
    /// The metric reference details when the reference is a scalar.
    scalar_reference_details: ?ScalarReferenceDetails = null,
};
