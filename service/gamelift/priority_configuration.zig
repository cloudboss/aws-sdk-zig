const PriorityType = @import("priority_type.zig").PriorityType;

/// Custom prioritization settings to use with a game session queue.
/// Prioritization
/// settings determine how the queue selects a game hosting resource to start a
/// new game
/// session. This configuration replaces the default prioritization process for
/// queues.
///
/// By default, a queue makes game session placements based on the following
/// criteria:
///
/// * When a game session request does not include player latency data, Amazon
///   GameLift Servers
/// places game sessions based on the following priorities: (1) the queue's
/// default
/// destination order, and (2) for multi-location fleets, an alphabetic list of
/// locations.
///
/// * When a game session request includes player latency data, Amazon GameLift
///   Servers re-orders
/// the queue's destinations to make placements where the average player latency
/// is
/// lowest. It reorders based the following priorities: (1) the lowest average
/// latency across all players, (2) the lowest hosting cost, (3) the queue's
/// default
/// destination order, and (4) for multi-location fleets, an alphabetic list of
/// locations.
pub const PriorityConfiguration = struct {
    /// The prioritization order to use for fleet locations, when the
    /// `PriorityOrder` property includes `LOCATION`. Locations can
    /// include Amazon Web Services Region codes (such as `us-west-2`), local zones,
    /// and custom
    /// locations (for Anywhere fleets). Each location must be listed only once. For
    /// details, see
    /// [Amazon GameLift Servers service
    /// locations.](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-regions.html)
    location_order: ?[]const []const u8 = null,

    /// A custom sequence to use when prioritizing where to place new game sessions.
    /// Each
    /// priority type is listed once.
    ///
    /// * `LATENCY` -- Amazon GameLift Servers prioritizes locations where the
    ///   average player
    /// latency is lowest. Player latency data is provided in each game session
    /// placement request.
    ///
    /// * `COST` -- Amazon GameLift Servers prioritizes queue destinations with the
    ///   lowest
    /// current hosting costs. Cost is evaluated based on the destination's
    /// location,
    /// instance type, and fleet type (Spot or On-Demand).
    ///
    /// * `DESTINATION` -- Amazon GameLift Servers prioritizes based on the list
    ///   order of
    /// destinations in the queue configuration.
    ///
    /// * `LOCATION` -- Amazon GameLift Servers prioritizes based on the provided
    ///   order of
    /// locations, as defined in `LocationOrder`.
    priority_order: ?[]const PriorityType = null,

    pub const json_field_names = .{
        .location_order = "LocationOrder",
        .priority_order = "PriorityOrder",
    };
};
