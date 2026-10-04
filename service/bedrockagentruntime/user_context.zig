/// Contains information about the user making the request. Use this to pass
/// user identity information for access control filtering, so that retrieval
/// results only include documents the user is authorized to access.
pub const UserContext = struct {
    /// The identifier of the user making the retrieval request.
    user_id: []const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
