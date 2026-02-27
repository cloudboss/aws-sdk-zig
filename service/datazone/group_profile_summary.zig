const GroupProfileStatus = @import("group_profile_status.zig").GroupProfileStatus;

/// The details of a group profile.
pub const GroupProfileSummary = struct {
    /// The ID of the Amazon DataZone domain of a group profile.
    domain_id: ?[]const u8,

    /// The group name of a group profile.
    group_name: ?[]const u8,

    /// The ID of a group profile.
    id: ?[]const u8,

    /// The status of a group profile.
    status: ?GroupProfileStatus,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .group_name = "groupName",
        .id = "id",
        .status = "status",
    };
};
