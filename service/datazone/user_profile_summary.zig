const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;
const UserProfileType = @import("user_profile_type.zig").UserProfileType;

/// The details of the user profile.
pub const UserProfileSummary = struct {
    /// The details of the user profile.
    details: ?UserProfileDetails,

    /// The ID of the Amazon DataZone domain of the user profile.
    domain_id: ?[]const u8,

    /// The ID of the user profile.
    id: ?[]const u8,

    /// The status of the user profile.
    status: ?UserProfileStatus,

    /// The type of the user profile.
    @"type": ?UserProfileType,

    pub const json_field_names = .{
        .details = "details",
        .domain_id = "domainId",
        .id = "id",
        .status = "status",
        .@"type" = "type",
    };
};
