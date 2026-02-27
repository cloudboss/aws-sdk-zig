/// The configuration of an event that the application subscribes.
pub const Subscription = struct {
    /// The description of the subscription.
    description: ?[]const u8,

    /// The name of the subscription.
    event: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .event = "Event",
    };
};
