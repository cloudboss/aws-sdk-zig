const FarmMember = @import("farm_member.zig").FarmMember;
const FleetMember = @import("fleet_member.zig").FleetMember;
const JobMember = @import("job_member.zig").JobMember;
const QueueMember = @import("queue_member.zig").QueueMember;

/// A membership record for a principal on a single Deadline Cloud resource. The
/// summary identifies the resource that the principal is a member of and the
/// principal's membership level for that resource.
pub const MembershipSummary = union(enum) {
    /// A membership on a farm.
    farm: ?FarmMember,
    /// A membership on a fleet.
    fleet: ?FleetMember,
    /// A membership on a job.
    job: ?JobMember,
    /// A membership on a queue.
    queue: ?QueueMember,

    pub const json_field_names = .{
        .farm = "farm",
        .fleet = "fleet",
        .job = "job",
        .queue = "queue",
    };
};
