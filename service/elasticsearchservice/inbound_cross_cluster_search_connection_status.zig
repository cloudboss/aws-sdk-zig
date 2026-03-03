const InboundCrossClusterSearchConnectionStatusCode = @import("inbound_cross_cluster_search_connection_status_code.zig").InboundCrossClusterSearchConnectionStatusCode;

/// Specifies the coonection status of an inbound cross-cluster search
/// connection.
pub const InboundCrossClusterSearchConnectionStatus = struct {
    /// Specifies verbose information for the inbound connection status.
    message: ?[]const u8 = null,

    /// The state code for inbound connection. This can be one of the following:
    ///
    /// * PENDING_ACCEPTANCE: Inbound connection is not yet accepted by destination
    ///   domain owner.
    ///
    /// * APPROVED: Inbound connection is pending acceptance by destination domain
    ///   owner.
    ///
    /// * REJECTING: Inbound connection rejection is in process.
    ///
    /// * REJECTED: Inbound connection is rejected.
    ///
    /// * DELETING: Inbound connection deletion is in progress.
    ///
    /// * DELETED: Inbound connection is deleted and cannot be used further.
    status_code: ?InboundCrossClusterSearchConnectionStatusCode = null,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
