const PrincipalMappingStatus = @import("principal_mapping_status.zig").PrincipalMappingStatus;

/// Summary information on the processing of `PUT` and `DELETE`
/// actions for mapping users to their groups.
pub const GroupOrderingIdSummary = struct {
    /// The reason an action could not be processed. An action can be a `PUT` or
    /// `DELETE` action for mapping users to their groups.
    failure_reason: ?[]const u8 = null,

    /// The Unix timestamp when an action was last updated. An action can be a `PUT`
    /// or `DELETE` action for mapping users to their groups.
    last_updated_at: ?i64 = null,

    /// The order in which actions should complete processing. An action can be a
    /// `PUT` or `DELETE` action for mapping users to their
    /// groups.
    ordering_id: ?i64 = null,

    /// The Unix timestamp when an action was received by Amazon Kendra. An action
    /// can
    /// be a `PUT` or `DELETE` action for mapping users to their groups.
    received_at: ?i64 = null,

    /// The current processing status of actions for mapping users to their groups.
    /// The status
    /// can be either `PROCESSING`, `SUCCEEDED`, `DELETING`,
    /// `DELETED`, or `FAILED`.
    status: ?PrincipalMappingStatus = null,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .last_updated_at = "LastUpdatedAt",
        .ordering_id = "OrderingId",
        .received_at = "ReceivedAt",
        .status = "Status",
    };
};
