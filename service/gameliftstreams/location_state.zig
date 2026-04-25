const StreamGroupLocationStatus = @import("stream_group_location_status.zig").StreamGroupLocationStatus;
const VpcTransitConfigurationResponse = @import("vpc_transit_configuration_response.zig").VpcTransitConfigurationResponse;

/// Represents a location and its corresponding stream capacity and status.
pub const LocationState = struct {
    /// This value is the stream capacity that Amazon GameLift Streams has
    /// provisioned in a stream group that can respond immediately to stream
    /// requests. It includes resources that are currently streaming and resources
    /// that are idle and ready to respond to stream requests. When target-idle
    /// capacity is configured, the idle resources include the capacity buffer
    /// maintained beyond ongoing sessions. You pay for this capacity whether it's
    /// in use or not. After making changes to capacity, it can take a few minutes
    /// for the allocated capacity count to reflect the change while compute
    /// resources are allocated or deallocated. Similarly, when allocated on-demand
    /// capacity is no longer needed, it can take a few minutes for Amazon GameLift
    /// Streams to spin down the allocated capacity.
    allocated_capacity: ?i32 = null,

    /// This setting, if non-zero, indicates minimum streaming capacity which is
    /// allocated to you and is never released back to the service. You pay for this
    /// base level of capacity at all times, whether used or idle.
    always_on_capacity: ?i32 = null,

    /// This value is the amount of allocated capacity that is not currently
    /// streaming. It represents the stream group's ability to respond immediately
    /// to new stream requests with near-instant startup time.
    idle_capacity: ?i32 = null,

    /// The CIDR block of the service VPC for this location. Add this CIDR block to
    /// your VPC route table to enable traffic routing through the Transit Gateway.
    internal_vpc_ipv_4_cidr_block: ?[]const u8 = null,

    /// A location's name. For example, `us-east-1`. For a complete list of
    /// locations that Amazon GameLift Streams supports, refer to [Regions, quotas,
    /// and
    /// limitations](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/regions-quotas.html) in the *Amazon GameLift Streams Developer Guide*.
    location_name: ?[]const u8 = null,

    /// This indicates the maximum capacity that the service can allocate for you.
    /// Newly created streams may take a few minutes to start. Capacity is released
    /// back to the service when idle. You pay for capacity that is allocated to you
    /// until it is released.
    maximum_capacity: ?i32 = null,

    /// The streaming capacity that Amazon GameLift Streams can allocate in response
    /// to stream requests, and then de-allocate when the session has terminated.
    /// This offers a cost control measure at the expense of a greater startup time
    /// (typically under 5 minutes). Default is 0 when creating a stream group or
    /// adding a location.
    on_demand_capacity: ?i32 = null,

    /// This value is the always-on capacity that you most recently requested for a
    /// stream group. You request capacity separately for each location in a stream
    /// group. In response to an increase in requested capacity, Amazon GameLift
    /// Streams attempts to provision compute resources to make the stream group's
    /// allocated capacity meet requested capacity. When always-on capacity is
    /// decreased, it can take a few minutes to deprovision allocated capacity to
    /// match the requested capacity.
    requested_capacity: ?i32 = null,

    /// This value is set of locations, including their name, current status, and
    /// capacities.
    ///
    /// A location can be in one of the following states:
    ///
    /// * `ACTIVATING`: Amazon GameLift Streams is preparing the location. You
    ///   cannot stream from, scale the capacity of, or remove this location yet.
    /// * `ACTIVE`: The location is provisioned with initial capacity. You can now
    ///   stream from, scale the capacity of, or remove this location.
    /// * `ERROR`: Amazon GameLift Streams failed to set up this location. The
    ///   `StatusReason` field describes the error. You can remove this location and
    ///   try to add it again.
    /// * `REMOVING`: Amazon GameLift Streams is working to remove this location.
    ///   This will release all provisioned capacity for this location in this
    ///   stream group.
    status: ?StreamGroupLocationStatus = null,

    /// This indicates idle capacity which the service pre-allocates and holds for
    /// you in anticipation of future activity. This helps to insulate your users
    /// from capacity-allocation delays. You pay for capacity which is held in this
    /// intentional idle state.
    target_idle_capacity: ?i32 = null,

    /// The VPC transit configuration for this location, including the Transit
    /// Gateway details needed to complete the VPC attachment setup.
    vpc_transit_configuration: ?VpcTransitConfigurationResponse = null,

    pub const json_field_names = .{
        .allocated_capacity = "AllocatedCapacity",
        .always_on_capacity = "AlwaysOnCapacity",
        .idle_capacity = "IdleCapacity",
        .internal_vpc_ipv_4_cidr_block = "InternalVpcIpv4CidrBlock",
        .location_name = "LocationName",
        .maximum_capacity = "MaximumCapacity",
        .on_demand_capacity = "OnDemandCapacity",
        .requested_capacity = "RequestedCapacity",
        .status = "Status",
        .target_idle_capacity = "TargetIdleCapacity",
        .vpc_transit_configuration = "VpcTransitConfiguration",
    };
};
