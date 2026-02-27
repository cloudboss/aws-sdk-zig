const ComputeMode = @import("compute_mode.zig").ComputeMode;
const ProvisionedCapacityResponse = @import("provisioned_capacity_response.zig").ProvisionedCapacityResponse;

/// The response to a request to retrieve or update the compute capacity
/// settings for querying data.
pub const QueryComputeResponse = struct {
    /// The mode in which Timestream Compute Units (TCUs) are allocated and utilized
    /// within an account. Note that in the Asia Pacific (Mumbai) region, the API
    /// operation only recognizes the value `PROVISIONED`.
    compute_mode: ?ComputeMode,

    /// Configuration object that contains settings for provisioned Timestream
    /// Compute Units (TCUs) in your account.
    provisioned_capacity: ?ProvisionedCapacityResponse,

    pub const json_field_names = .{
        .compute_mode = "ComputeMode",
        .provisioned_capacity = "ProvisionedCapacity",
    };
};
