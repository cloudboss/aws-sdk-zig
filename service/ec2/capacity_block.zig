const CapacityBlockResourceState = @import("capacity_block_resource_state.zig").CapacityBlockResourceState;
const Tag = @import("tag.zig").Tag;

/// Reserve powerful GPU instances on a future date to support your short
/// duration machine learning (ML) workloads. Instances that run inside a
/// Capacity Block are automatically placed close together inside [Amazon EC2
/// UltraClusters](http://aws.amazon.com/ec2/ultraclusters/), for low-latency,
/// petabit-scale, non-blocking networking.
///
/// You can also reserve Amazon EC2 UltraServers. UltraServers connect multiple
/// EC2 instances using a low-latency, high-bandwidth accelerator interconnect
/// (NeuronLink). They are built to tackle very large-scale AI/ML workloads that
/// require significant processing power. For more information, see Amazon EC2
/// UltraServers.
pub const CapacityBlock = struct {
    /// The Availability Zone of the Capacity Block.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID of the Capacity Block.
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the Capacity Block.
    capacity_block_id: ?[]const u8 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_ids: ?[]const []const u8 = null,

    /// The date and time at which the Capacity Block was created.
    create_date: ?i64 = null,

    /// The date and time at which the Capacity Block expires. When a Capacity Block
    /// expires,
    /// all instances in the Capacity Block are terminated.
    end_date: ?i64 = null,

    /// The date and time at which the Capacity Block was started.
    start_date: ?i64 = null,

    /// The state of the Capacity Block.
    state: ?CapacityBlockResourceState = null,

    /// The tags assigned to the Capacity Block.
    tags: ?[]const Tag = null,

    /// The EC2 UltraServer type of the Capacity Block.
    ultraserver_type: ?[]const u8 = null,
};
