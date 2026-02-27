const UserDetails = @import("user_details.zig").UserDetails;

/// A container object for the session details that are associated with a
/// workflow.
pub const ServiceMetadata = struct {
    /// The Server ID (`ServerId`), Session ID (`SessionId`) and user (`UserName`)
    /// make up the `UserDetails`.
    user_details: UserDetails,

    pub const json_field_names = .{
        .user_details = "UserDetails",
    };
};
