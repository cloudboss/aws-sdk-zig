const ReservedInstancesModificationResult = @import("reserved_instances_modification_result.zig").ReservedInstancesModificationResult;
const ReservedInstancesId = @import("reserved_instances_id.zig").ReservedInstancesId;

/// Describes a Reserved Instance modification.
pub const ReservedInstancesModification = struct {
    /// A unique, case-sensitive key supplied by the client to ensure that the
    /// request is
    /// idempotent. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// The time when the modification request was created.
    create_date: ?i64,

    /// The time for the modification to become effective.
    effective_date: ?i64,

    /// Contains target configurations along with their corresponding new Reserved
    /// Instance
    /// IDs.
    modification_results: ?[]const ReservedInstancesModificationResult,

    /// The IDs of one or more Reserved Instances.
    reserved_instances_ids: ?[]const ReservedInstancesId,

    /// A unique ID for the Reserved Instance modification.
    reserved_instances_modification_id: ?[]const u8,

    /// The status of the Reserved Instances modification request.
    status: ?[]const u8,

    /// The reason for the status.
    status_message: ?[]const u8,

    /// The time when the modification request was last updated.
    update_date: ?i64,
};
