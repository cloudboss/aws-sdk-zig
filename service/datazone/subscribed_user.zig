const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;

/// The subscribed user.
pub const SubscribedUser = struct {
    /// The subscribed user details.
    details: ?UserProfileDetails,

    /// The ID of the subscribed user.
    id: ?[]const u8,

    pub const json_field_names = .{
        .details = "details",
        .id = "id",
    };
};
