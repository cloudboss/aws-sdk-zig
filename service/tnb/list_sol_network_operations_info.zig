const ProblemDetails = @import("problem_details.zig").ProblemDetails;
const LcmOperationType = @import("lcm_operation_type.zig").LcmOperationType;
const ListSolNetworkOperationsMetadata = @import("list_sol_network_operations_metadata.zig").ListSolNetworkOperationsMetadata;
const NsLcmOperationState = @import("ns_lcm_operation_state.zig").NsLcmOperationState;
const UpdateSolNetworkType = @import("update_sol_network_type.zig").UpdateSolNetworkType;

/// Information parameters for a network operation.
pub const ListSolNetworkOperationsInfo = struct {
    /// Network operation ARN.
    arn: []const u8,

    /// Error related to this specific network operation.
    @"error": ?ProblemDetails,

    /// ID of this network operation.
    id: []const u8,

    /// Type of lifecycle management network operation.
    lcm_operation_type: LcmOperationType,

    /// Metadata related to this network operation.
    metadata: ?ListSolNetworkOperationsMetadata,

    /// ID of the network instance related to this operation.
    ns_instance_id: []const u8,

    /// The state of the network operation.
    operation_state: NsLcmOperationState,

    /// Type of the update. Only present if the network operation lcmOperationType
    /// is `UPDATE`.
    update_type: ?UpdateSolNetworkType,

    pub const json_field_names = .{
        .arn = "arn",
        .@"error" = "error",
        .id = "id",
        .lcm_operation_type = "lcmOperationType",
        .metadata = "metadata",
        .ns_instance_id = "nsInstanceId",
        .operation_state = "operationState",
        .update_type = "updateType",
    };
};
