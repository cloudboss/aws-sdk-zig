/// The project that has the subscription grant.
pub const SubscribedProject = struct {
    /// The identifier of the project that has the subscription grant.
    id: ?[]const u8 = null,

    /// The name of the project that has the subscription grant.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
