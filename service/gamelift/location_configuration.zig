/// A remote location where a multi-location fleet can deploy game servers for
/// game
/// hosting.
pub const LocationConfiguration = struct {
    /// An Amazon Web Services Region code, such as `us-west-2`. For a list of
    /// supported Regions
    /// and Local Zones, see [ Amazon GameLift Servers service
    /// locations](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-regions.html) for managed hosting.
    location: []const u8,

    pub const json_field_names = .{
        .location = "Location",
    };
};
