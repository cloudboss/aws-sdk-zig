const ComputeMode = @import("compute_mode.zig").ComputeMode;
const ProvisionedCapacityRequest = @import("provisioned_capacity_request.zig").ProvisionedCapacityRequest;

/// A request to retrieve or update the compute capacity settings for querying
/// data.
pub const QueryComputeRequest = struct {
    /// The mode in which Timestream Compute Units (TCUs) are allocated and utilized
    /// within an account. Note that in the Asia Pacific (Mumbai) region, the API
    /// operation only recognizes the value `PROVISIONED`.
    compute_mode: ?ComputeMode,

    /// Configuration object that contains settings for provisioned Timestream
    /// Compute Units (TCUs) in your account.
    provisioned_capacity: ?ProvisionedCapacityRequest,

    pub const json_field_names = .{
        .compute_mode = "ComputeMode",
        .provisioned_capacity = "ProvisionedCapacity",
    };
};
