const FairShare = @import("fair_share.zig").FairShare;
const IdleResourceSharing = @import("idle_resource_sharing.zig").IdleResourceSharing;
const PriorityClass = @import("priority_class.zig").PriorityClass;

/// Cluster policy configuration. This policy is used for task prioritization
/// and fair-share allocation. This helps prioritize critical workloads and
/// distributes idle compute across entities.
pub const SchedulerConfig = struct {
    /// When enabled, entities borrow idle compute based on their assigned
    /// `FairShareWeight`.
    ///
    /// When disabled, entities borrow idle compute based on a first-come
    /// first-serve basis.
    ///
    /// Default is `Enabled`.
    fair_share: ?FairShare,

    /// Configuration for sharing idle compute resources across entities in the
    /// cluster. When enabled, unallocated resources are automatically calculated
    /// and made available for entities to borrow.
    idle_resource_sharing: ?IdleResourceSharing,

    /// List of the priority classes, `PriorityClass`, of the cluster policy. When
    /// specified, these class configurations define how tasks are queued.
    priority_classes: ?[]const PriorityClass,

    pub const json_field_names = .{
        .fair_share = "FairShare",
        .idle_resource_sharing = "IdleResourceSharing",
        .priority_classes = "PriorityClasses",
    };
};
