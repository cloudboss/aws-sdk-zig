const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;
const UserProfileType = @import("user_profile_type.zig").UserProfileType;

/// The details of the user profile.
pub const UserProfileSummary = struct {
    /// The details of the user profile.
    details: ?UserProfileDetails = null,

    /// The ID of the Amazon DataZone domain of the user profile.
    domain_id: ?[]const u8 = null,

    /// The ID of the user profile.
    id: ?[]const u8 = null,

    /// The status of the user profile.
    status: ?UserProfileStatus = null,

    /// The type of the user profile.
    @"type": ?UserProfileType = null,

    pub const json_field_names = .{
        .details = "details",
        .domain_id = "domainId",
        .id = "id",
        .status = "status",
        .@"type" = "type",
    };
};
