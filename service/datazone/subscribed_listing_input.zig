/// The published asset for which the subscription grant is to be created.
pub const SubscribedListingInput = struct {
    /// The identifier of the published asset for which the subscription grant is to
    /// be created.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
