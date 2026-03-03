const ClusterAssociatedToSchedule = @import("cluster_associated_to_schedule.zig").ClusterAssociatedToSchedule;
const Tag = @import("tag.zig").Tag;

/// Describes a snapshot schedule. You can set a regular interval for creating
/// snapshots of a cluster. You can also schedule snapshots for specific dates.
pub const SnapshotSchedule = struct {
    /// The number of clusters associated with the schedule.
    associated_cluster_count: ?i32 = null,

    /// A list of clusters associated with the schedule. A maximum of 100 clusters
    /// is returned.
    associated_clusters: ?[]const ClusterAssociatedToSchedule = null,

    next_invocations: ?[]const i64 = null,

    /// A list of ScheduleDefinitions.
    schedule_definitions: ?[]const []const u8 = null,

    /// The description of the schedule.
    schedule_description: ?[]const u8 = null,

    /// A unique identifier for the schedule.
    schedule_identifier: ?[]const u8 = null,

    /// An optional set of tags describing the schedule.
    tags: ?[]const Tag = null,
};
