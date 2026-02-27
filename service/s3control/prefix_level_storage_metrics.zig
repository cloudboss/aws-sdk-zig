const SelectionCriteria = @import("selection_criteria.zig").SelectionCriteria;

/// A container for the prefix-level storage metrics for S3 Storage Lens.
pub const PrefixLevelStorageMetrics = struct {
    /// A container for whether prefix-level storage metrics are enabled.
    is_enabled: bool = false,

    selection_criteria: ?SelectionCriteria,
};
