const ReservationEndDateType = @import("reservation_end_date_type.zig").ReservationEndDateType;
const ReservationState = @import("reservation_state.zig").ReservationState;
const ReservationType = @import("reservation_type.zig").ReservationType;
const CapacityTenancy = @import("capacity_tenancy.zig").CapacityTenancy;

/// Represents dimension values for capacity metrics, including resource
/// identifiers, geographic information, and reservation details used for
/// grouping and filtering capacity data.
pub const CapacityManagerDimension = struct {
    /// The Amazon Web Services account ID that owns the capacity resource.
    account_id: ?[]const u8,

    /// The unique identifier of the Availability Zone where the capacity resource
    /// is located.
    availability_zone_id: ?[]const u8,

    /// The EC2 instance family of the capacity resource.
    instance_family: ?[]const u8,

    /// The platform or operating system of the instance.
    instance_platform: ?[]const u8,

    /// The specific EC2 instance type of the capacity resource.
    instance_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the capacity reservation. This provides a
    /// unique identifier that can be used across Amazon Web Services services to
    /// reference the specific reservation.
    reservation_arn: ?[]const u8,

    /// The timestamp when the capacity reservation was originally created, in
    /// milliseconds since epoch. This differs from the start timestamp as
    /// reservations can be created before they become active.
    reservation_create_timestamp: ?i64,

    /// The type of end date for the capacity reservation. This indicates whether
    /// the reservation has a fixed end date, is open-ended, or follows a specific
    /// termination pattern.
    reservation_end_date_type: ?ReservationEndDateType,

    /// The timestamp when the capacity reservation expires and is no longer
    /// available, in milliseconds since epoch. After this time, the reservation
    /// will not provide any capacity.
    reservation_end_timestamp: ?i64,

    /// The unique identifier of the capacity reservation.
    reservation_id: ?[]const u8,

    /// The instance matching criteria for the capacity reservation, determining how
    /// instances are matched to the reservation.
    reservation_instance_match_criteria: ?[]const u8,

    /// The timestamp when the capacity reservation becomes active and available for
    /// use, in milliseconds since epoch. This is when the reservation begins
    /// providing capacity.
    reservation_start_timestamp: ?i64,

    /// The current state of the capacity reservation.
    reservation_state: ?ReservationState,

    /// The type of capacity reservation.
    reservation_type: ?ReservationType,

    /// The Amazon Web Services account ID that is financially responsible for
    /// unused capacity reservation costs.
    reservation_unused_financial_owner: ?[]const u8,

    /// The Amazon Web Services Region where the capacity resource is located.
    resource_region: ?[]const u8,

    /// The tenancy of the EC2 instances associated with this capacity dimension.
    /// Valid values are 'default' for shared tenancy, 'dedicated' for dedicated
    /// instances, or 'host' for dedicated hosts.
    tenancy: ?CapacityTenancy,
};
