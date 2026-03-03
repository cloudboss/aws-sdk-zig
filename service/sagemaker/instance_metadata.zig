const AdditionalEnis = @import("additional_enis.zig").AdditionalEnis;
const CapacityReservation = @import("capacity_reservation.zig").CapacityReservation;

/// Metadata information about an instance in a HyperPod cluster.
pub const InstanceMetadata = struct {
    /// Information about additional Elastic Network Interfaces (ENIs) associated
    /// with the instance.
    additional_enis: ?AdditionalEnis = null,

    /// Information about the Capacity Reservation used by the instance.
    capacity_reservation: ?CapacityReservation = null,

    /// The ID of the customer-managed Elastic Network Interface (ENI) associated
    /// with the instance.
    customer_eni: ?[]const u8 = null,

    /// An error message describing why the instance creation or update failed, if
    /// applicable.
    failure_message: ?[]const u8 = null,

    /// The execution state of the Lifecycle Script (LCS) for the instance.
    lcs_execution_state: ?[]const u8 = null,

    /// The unique logical identifier of the node within the cluster. The ID used
    /// here is the same object as in the `BatchAddClusterNodes` API.
    node_logical_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_enis = "AdditionalEnis",
        .capacity_reservation = "CapacityReservation",
        .customer_eni = "CustomerEni",
        .failure_message = "FailureMessage",
        .lcs_execution_state = "LcsExecutionState",
        .node_logical_id = "NodeLogicalId",
    };
};
