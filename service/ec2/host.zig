const AllowsMultipleInstanceTypes = @import("allows_multiple_instance_types.zig").AllowsMultipleInstanceTypes;
const AutoPlacement = @import("auto_placement.zig").AutoPlacement;
const AvailableCapacity = @import("available_capacity.zig").AvailableCapacity;
const HostMaintenance = @import("host_maintenance.zig").HostMaintenance;
const HostProperties = @import("host_properties.zig").HostProperties;
const HostRecovery = @import("host_recovery.zig").HostRecovery;
const HostInstance = @import("host_instance.zig").HostInstance;
const AllocationState = @import("allocation_state.zig").AllocationState;
const Tag = @import("tag.zig").Tag;

/// Describes the properties of the Dedicated Host.
pub const Host = struct {
    /// The time that the Dedicated Host was allocated.
    allocation_time: ?i64,

    /// Indicates whether the Dedicated Host supports multiple instance types of the
    /// same
    /// instance family. If the value is `on`, the Dedicated Host supports multiple
    /// instance types in the instance family. If the value is `off`, the Dedicated
    /// Host supports a single instance type only.
    allows_multiple_instance_types: ?AllowsMultipleInstanceTypes,

    /// The ID of the Outpost hardware asset on which the Dedicated Host is
    /// allocated.
    asset_id: ?[]const u8,

    /// Whether auto-placement is on or off.
    auto_placement: ?AutoPlacement,

    /// The Availability Zone of the Dedicated Host.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone in which the Dedicated Host is allocated.
    availability_zone_id: ?[]const u8,

    /// Information about the instances running on the Dedicated Host.
    available_capacity: ?AvailableCapacity,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// The ID of the Dedicated Host.
    host_id: ?[]const u8,

    /// Indicates whether host maintenance is enabled or disabled for the Dedicated
    /// Host.
    host_maintenance: ?HostMaintenance,

    /// The hardware specifications of the Dedicated Host.
    host_properties: ?HostProperties,

    /// Indicates whether host recovery is enabled or disabled for the Dedicated
    /// Host.
    host_recovery: ?HostRecovery,

    /// The reservation ID of the Dedicated Host. This returns a `null` response if
    /// the Dedicated Host doesn't have an associated reservation.
    host_reservation_id: ?[]const u8,

    /// The IDs and instance type that are currently running on the Dedicated Host.
    instances: ?[]const HostInstance,

    /// Indicates whether the Dedicated Host is in a host resource group. If
    /// **memberOfServiceLinkedResourceGroup** is `true`, the
    /// host is in a host resource group; otherwise, it is not.
    member_of_service_linked_resource_group: ?bool,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Outpost on which
    /// the
    /// Dedicated Host is allocated.
    outpost_arn: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the Dedicated Host.
    owner_id: ?[]const u8,

    /// The time that the Dedicated Host was released.
    release_time: ?i64,

    /// The Dedicated Host's state.
    state: ?AllocationState,

    /// Any tags assigned to the Dedicated Host.
    tags: ?[]const Tag,
};
