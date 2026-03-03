/// The project that is to be given a subscription grant.
pub const SubscribedProjectInput = struct {
    /// The identifier of the project that is to be given a subscription grant.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
