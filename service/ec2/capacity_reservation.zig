const CapacityAllocation = @import("capacity_allocation.zig").CapacityAllocation;
const CapacityReservationCommitmentInfo = @import("capacity_reservation_commitment_info.zig").CapacityReservationCommitmentInfo;
const CapacityReservationDeliveryPreference = @import("capacity_reservation_delivery_preference.zig").CapacityReservationDeliveryPreference;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;
const CapacityReservationInstancePlatform = @import("capacity_reservation_instance_platform.zig").CapacityReservationInstancePlatform;
const InterruptibleCapacityAllocation = @import("interruptible_capacity_allocation.zig").InterruptibleCapacityAllocation;
const InterruptionInfo = @import("interruption_info.zig").InterruptionInfo;
const CapacityReservationType = @import("capacity_reservation_type.zig").CapacityReservationType;
const CapacityReservationState = @import("capacity_reservation_state.zig").CapacityReservationState;
const Tag = @import("tag.zig").Tag;
const CapacityReservationTenancy = @import("capacity_reservation_tenancy.zig").CapacityReservationTenancy;

/// Describes a Capacity Reservation.
pub const CapacityReservation = struct {
    /// The Availability Zone in which the capacity is reserved.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone in which the capacity is reserved.
    availability_zone_id: ?[]const u8 = null,

    /// The remaining capacity. Indicates the number of instances that can be
    /// launched in the
    /// Capacity Reservation.
    available_instance_count: ?i32 = null,

    /// Information about instance capacity usage.
    capacity_allocations: ?[]const CapacityAllocation = null,

    /// The ID of the Capacity Block.
    capacity_block_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Capacity Reservation.
    capacity_reservation_arn: ?[]const u8 = null,

    /// The ID of the Capacity Reservation Fleet to which the Capacity Reservation
    /// belongs.
    /// Only valid for Capacity Reservations that were created by a Capacity
    /// Reservation
    /// Fleet.
    capacity_reservation_fleet_id: ?[]const u8 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8 = null,

    /// Information about your commitment for a future-dated Capacity Reservation.
    commitment_info: ?CapacityReservationCommitmentInfo = null,

    /// The date and time the Capacity Reservation was created.
    create_date: ?i64 = null,

    /// The delivery method for a future-dated Capacity Reservation. `incremental`
    /// indicates that the requested capacity is delivered in addition to any
    /// running instances
    /// and reserved capacity that you have in your account at the requested date
    /// and
    /// time.
    delivery_preference: ?CapacityReservationDeliveryPreference = null,

    /// Indicates whether the Capacity Reservation supports EBS-optimized instances.
    /// This
    /// optimization provides dedicated throughput to Amazon EBS and an optimized
    /// configuration
    /// stack to provide optimal I/O performance. This optimization isn't available
    /// with all
    /// instance types. Additional usage charges apply when using an EBS- optimized
    /// instance.
    ebs_optimized: ?bool = null,

    /// The date and time the Capacity Reservation expires. When a Capacity
    /// Reservation expires, the reserved capacity is released and you can no longer
    /// launch
    /// instances into it. The Capacity Reservation's state changes to `expired`
    /// when
    /// it reaches its end date and time.
    end_date: ?i64 = null,

    /// Indicates the way in which the Capacity Reservation ends. A Capacity
    /// Reservation can
    /// have one of the following end types:
    ///
    /// * `unlimited` - The Capacity Reservation remains active until you
    /// explicitly cancel it.
    ///
    /// * `limited` - The Capacity Reservation expires automatically at a
    /// specified date and time.
    end_date_type: ?EndDateType = null,

    /// *Deprecated.*
    ephemeral_storage: ?bool = null,

    /// Indicates the type of instance launches that the Capacity Reservation
    /// accepts. The
    /// options include:
    ///
    /// * `open` - The Capacity Reservation accepts all instances that have
    /// matching attributes (instance type, platform, and Availability Zone).
    /// Instances
    /// that have matching attributes launch into the Capacity Reservation
    /// automatically
    /// without specifying any additional parameters.
    ///
    /// * `targeted` - The Capacity Reservation only accepts instances that
    /// have matching attributes (instance type, platform, and Availability Zone),
    /// and
    /// explicitly target the Capacity Reservation. This ensures that only permitted
    /// instances can use the reserved capacity.
    instance_match_criteria: ?InstanceMatchCriteria = null,

    /// The type of operating system for which the Capacity Reservation reserves
    /// capacity.
    instance_platform: ?CapacityReservationInstancePlatform = null,

    /// The type of instance for which the Capacity Reservation reserves capacity.
    instance_type: ?[]const u8 = null,

    /// Indicates whether this Capacity Reservation is interruptible, meaning
    /// instances may be terminated when the owner reclaims capacity.
    interruptible: ?bool = null,

    /// Contains allocation details for interruptible reservations, including
    /// current allocated instances and target instance counts within the
    /// interruptibleCapacityAllocation object.
    interruptible_capacity_allocation: ?InterruptibleCapacityAllocation = null,

    /// Information about the interruption configuration and association with the
    /// source reservation for interruptible Capacity Reservations.
    interruption_info: ?InterruptionInfo = null,

    /// The Amazon Resource Name (ARN) of the Outpost on which the Capacity
    /// Reservation was
    /// created.
    outpost_arn: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the Capacity
    /// Reservation.
    owner_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster placement group in which the
    /// Capacity
    /// Reservation was created. For more information, see [ Capacity Reservations
    /// for cluster
    /// placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cr-cpg.html) in
    /// the *Amazon EC2 User Guide*.
    placement_group_arn: ?[]const u8 = null,

    /// The type of Capacity Reservation.
    reservation_type: ?CapacityReservationType = null,

    /// The date and time the Capacity Reservation was started.
    start_date: ?i64 = null,

    /// The current state of the Capacity Reservation. A Capacity Reservation can be
    /// in one of
    /// the following states:
    ///
    /// * `active` - The capacity is available for use.
    ///
    /// * `expired` - The Capacity Reservation expired automatically at the date and
    ///   time
    /// specified in your reservation request. The reserved capacity is no longer
    /// available for your use.
    ///
    /// * `cancelled` - The Capacity Reservation was canceled. The reserved capacity
    ///   is no
    /// longer available for your use.
    ///
    /// * `pending` - The Capacity Reservation request was successful but the
    ///   capacity
    /// provisioning is still pending.
    ///
    /// * `failed` - The Capacity Reservation request has failed. A request can fail
    ///   due to
    /// request parameters that are not valid, capacity constraints, or instance
    /// limit constraints. You
    /// can view a failed request for 60 minutes.
    ///
    /// * `scheduled` - (*Future-dated Capacity Reservations*) The
    /// future-dated Capacity Reservation request was approved and the Capacity
    /// Reservation is scheduled
    /// for delivery on the requested start date.
    ///
    /// * `payment-pending` - (*Capacity Blocks*) The upfront
    /// payment has not been processed yet.
    ///
    /// * `payment-failed` - (*Capacity Blocks*) The upfront
    /// payment was not processed in the 12-hour time frame. Your Capacity Block was
    /// released.
    ///
    /// * `assessing` - (*Future-dated Capacity Reservations*)
    /// Amazon EC2 is assessing your request for a future-dated Capacity
    /// Reservation.
    ///
    /// * `delayed` - (*Future-dated Capacity Reservations*) Amazon EC2
    /// encountered a delay in provisioning the requested future-dated Capacity
    /// Reservation. Amazon EC2 is
    /// unable to deliver the requested capacity by the requested start date and
    /// time.
    ///
    /// * `unsupported` - (*Future-dated Capacity Reservations*) Amazon EC2
    /// can't support the future-dated Capacity Reservation request due to capacity
    /// constraints. You can view
    /// unsupported requests for 30 days. The Capacity Reservation will not be
    /// delivered.
    state: ?CapacityReservationState = null,

    /// Any tags assigned to the Capacity Reservation.
    tags: ?[]const Tag = null,

    /// Indicates the tenancy of the Capacity Reservation. A Capacity Reservation
    /// can have one
    /// of the following tenancy settings:
    ///
    /// * `default` - The Capacity Reservation is created on hardware that is
    /// shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Reservation is created on single-tenant
    /// hardware that is dedicated to a single Amazon Web Services account.
    tenancy: ?CapacityReservationTenancy = null,

    /// The total number of instances for which the Capacity Reservation reserves
    /// capacity.
    total_instance_count: ?i32 = null,

    /// The ID of the Amazon Web Services account to which billing of the unused
    /// capacity of
    /// the Capacity Reservation is assigned.
    unused_reservation_billing_owner_id: ?[]const u8 = null,
};
