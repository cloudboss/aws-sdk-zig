/// Configuration settings that define a stream group's stream capacity for a
/// location. When configuring a location for the first time, you must specify a
/// numeric value for at least one of the two capacity types. To update the
/// capacity for an existing stream group, call
/// [UpdateStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_UpdateStreamGroup.html). To add a new location and specify its capacity, call [AddStreamGroupLocations](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_AddStreamGroupLocations.html).
pub const LocationConfiguration = struct {
    /// This setting, if non-zero, indicates minimum streaming capacity which is
    /// allocated to you and is never released back to the service. You pay for this
    /// base level of capacity at all times, whether used or idle.
    always_on_capacity: ?i32,

    /// A location's name. For example, `us-east-1`. For a complete list of
    /// locations that Amazon GameLift Streams supports, refer to [Regions, quotas,
    /// and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    location_name: []const u8,

    /// This indicates the maximum capacity that the service can allocate for you.
    /// Newly created streams may take a few minutes to start. Capacity is released
    /// back to the service when idle. You pay for capacity that is allocated to you
    /// until it is released.
    maximum_capacity: ?i32,

    /// This field is deprecated. Use `MaximumCapacity` instead. This parameter
    /// cannot be used with `MaximumCapacity` or `TargetIdleCapacity` in the same
    /// location configuration.
    ///
    /// The streaming capacity that Amazon GameLift Streams can allocate in response
    /// to stream requests, and then de-allocate when the session has terminated.
    /// This offers a cost control measure at the expense of a greater startup time
    /// (typically under 5 minutes). Default is 0 when creating a stream group or
    /// adding a location.
    on_demand_capacity: ?i32,

    /// This indicates idle capacity which the service pre-allocates and holds for
    /// you in anticipation of future activity. This helps to insulate your users
    /// from capacity-allocation delays. You pay for capacity which is held in this
    /// intentional idle state.
    target_idle_capacity: ?i32,

    pub const json_field_names = .{
        .always_on_capacity = "AlwaysOnCapacity",
        .location_name = "LocationName",
        .maximum_capacity = "MaximumCapacity",
        .on_demand_capacity = "OnDemandCapacity",
        .target_idle_capacity = "TargetIdleCapacity",
    };
};
