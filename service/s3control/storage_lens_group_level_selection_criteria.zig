/// Indicates which Storage Lens group ARNs to include or exclude in the Storage
/// Lens group
/// aggregation. You can only attach Storage Lens groups to your Storage Lens
/// dashboard if
/// they're included in your Storage Lens group aggregation. If this value is
/// left null, then
/// all Storage Lens groups are selected.
pub const StorageLensGroupLevelSelectionCriteria = struct {
    /// Indicates which Storage Lens group ARNs to exclude from the Storage Lens
    /// group
    /// aggregation.
    exclude: ?[]const []const u8,

    /// Indicates which Storage Lens group ARNs to include in the Storage Lens group
    /// aggregation.
    include: ?[]const []const u8,
};
