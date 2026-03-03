const StorageLensGroupLevelSelectionCriteria = @import("storage_lens_group_level_selection_criteria.zig").StorageLensGroupLevelSelectionCriteria;

/// Specifies the Storage Lens groups to include in the Storage Lens group
/// aggregation.
pub const StorageLensGroupLevel = struct {
    /// Indicates which Storage Lens group ARNs to include or exclude in the Storage
    /// Lens group
    /// aggregation. If this value is left null, then all Storage Lens groups are
    /// selected.
    selection_criteria: ?StorageLensGroupLevelSelectionCriteria = null,
};
