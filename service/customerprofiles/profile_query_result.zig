const Profile = @import("profile.zig").Profile;
const QueryResult = @import("query_result.zig").QueryResult;

/// Object that holds the results for membership.
pub const ProfileQueryResult = struct {
    profile: ?Profile = null,

    /// The profile id the result belongs to.
    profile_id: []const u8,

    /// Describes whether the profile was absent or present in the segment.
    query_result: QueryResult,

    pub const json_field_names = .{
        .profile = "Profile",
        .profile_id = "ProfileId",
        .query_result = "QueryResult",
    };
};
