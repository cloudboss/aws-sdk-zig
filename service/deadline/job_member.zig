const MembershipLevel = @import("membership_level.zig").MembershipLevel;
const DeadlinePrincipalType = @import("deadline_principal_type.zig").DeadlinePrincipalType;

/// The details for a job member.
pub const JobMember = struct {
    /// The farm ID.
    farm_id: []const u8,

    /// The identity store ID.
    identity_store_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The job member's membership level.
    membership_level: MembershipLevel,

    /// The principal ID of the job member.
    principal_id: []const u8,

    /// The principal type of the job member.
    principal_type: DeadlinePrincipalType,

    /// The queue ID.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .identity_store_id = "identityStoreId",
        .job_id = "jobId",
        .membership_level = "membershipLevel",
        .principal_id = "principalId",
        .principal_type = "principalType",
        .queue_id = "queueId",
    };
};
