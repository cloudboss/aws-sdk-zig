/// Amazon GameLift Servers configuration options for your Anywhere fleets.
pub const AnywhereConfiguration = struct {
    /// The cost to run your fleet per hour. Amazon GameLift Servers uses the
    /// provided cost of your fleet to
    /// balance usage in queues. For more information about queues, see [Setting
    /// up
    /// queues](https://docs.aws.amazon.com/gamelift/latest/developerguide/queues-intro.html) in the *Amazon GameLift Servers Developer Guide*.
    cost: []const u8,

    pub const json_field_names = .{
        .cost = "Cost",
    };
};
