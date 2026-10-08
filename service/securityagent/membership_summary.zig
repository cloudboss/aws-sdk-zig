const MembershipConfig = @import("membership_config.zig").MembershipConfig;
const MembershipType = @import("membership_type.zig").MembershipType;
const MemberMetadata = @import("member_metadata.zig").MemberMetadata;

/// Contains summary information about a membership.
pub const MembershipSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The unique identifier of the application.
    application_id: []const u8,

    /// The configuration for the membership.
    config: ?MembershipConfig = null,

    /// The date and time the membership was created, in UTC format.
    created_at: i64,

    /// The identifier of the entity that created the membership.
    created_by: []const u8,

    /// The unique identifier of the membership.
    membership_id: []const u8,

    /// The type of member.
    member_type: MembershipType,

    /// The metadata for the member.
    metadata: ?MemberMetadata = null,

    /// The date and time the membership was last updated, in UTC format.
    updated_at: i64,

    /// The identifier of the entity that last updated the membership.
    updated_by: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .application_id = "applicationId",
        .config = "config",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .membership_id = "membershipId",
        .member_type = "memberType",
        .metadata = "metadata",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
