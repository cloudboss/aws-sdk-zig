/// A structure that describes details for authentication that uses IAM.
pub const IamAuthenticationMethod = struct {
    /// An IAM policy document in JSON.
    actor_policy: []const u8,

    pub const json_field_names = .{
        .actor_policy = "ActorPolicy",
    };
};
