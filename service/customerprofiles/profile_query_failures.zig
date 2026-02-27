/// Object that holds failures for membership.
pub const ProfileQueryFailures = struct {
    /// A message describing the failure.
    message: []const u8,

    /// The profile id the failure belongs to.
    profile_id: []const u8,

    /// The status describing the failure.
    status: ?i32,

    pub const json_field_names = .{
        .message = "Message",
        .profile_id = "ProfileId",
        .status = "Status",
    };
};
