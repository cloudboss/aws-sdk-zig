const PlacementFallbackStrategy = @import("placement_fallback_strategy.zig").PlacementFallbackStrategy;

/// An alternate list of prioritized locations for use with a game session
/// queue. When
/// this property is included in a
/// [StartGameSessionPlacement](https://docs.aws.amazon.com/gamelift/latest/apireference/API_StartGameSessionPlacement.html) request, the alternate list overrides the queue's
/// default location priorities, as defined in the queue's
/// [PriorityConfiguration](gamelift/latest/apireference/API_PriorityConfiguration.html) setting (*LocationOrder*). The
/// override is valid for an individual placement request only. Use this
/// property only with
/// queues that have a `PriorityConfiguration` setting that prioritizes
/// `LOCATION` first.
///
/// A priority configuration override list does not override a queue's
/// FilterConfiguration setting, if the queue has one. Filter configurations are
/// used to
/// limit placements to a subset of the locations in a queue's destinations. If
/// the
/// override list includes a location that's not on in the
/// `FilterConfiguration` allowed list, Amazon GameLift Servers won't attempt to
/// place a
/// game session there.
pub const PriorityConfigurationOverride = struct {
    /// A prioritized list of hosting locations. The list can include Amazon Web
    /// Services Regions (such as
    /// `us-west-2`), local zones, and custom locations (for Anywhere fleets).
    /// Each location must be listed only once. For details, see
    /// [Amazon GameLift Servers service
    /// locations.](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-regions.html)
    location_order: []const []const u8,

    /// Instructions for how to proceed if placement fails in every location on the
    /// priority
    /// override list. Valid strategies include:
    ///
    /// * `DEFAULT_AFTER_SINGLE_PASS` -- After attempting to place a new game
    ///   session in
    /// every location on the priority override list, try to place a game session in
    /// queue's other locations. This is the default behavior.
    ///
    /// * `NONE` -- Limit placements to locations on the priority override list
    ///   only.
    placement_fallback_strategy: ?PlacementFallbackStrategy,

    pub const json_field_names = .{
        .location_order = "LocationOrder",
        .placement_fallback_strategy = "PlacementFallbackStrategy",
    };
};
