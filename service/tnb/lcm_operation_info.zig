/// Lifecycle management operation details on the network instance.
///
/// Lifecycle management operations are deploy, update, or delete operations.
pub const LcmOperationInfo = struct {
    /// The identifier of the network operation.
    ns_lcm_op_occ_id: []const u8,

    pub const json_field_names = .{
        .ns_lcm_op_occ_id = "nsLcmOpOccId",
    };
};
