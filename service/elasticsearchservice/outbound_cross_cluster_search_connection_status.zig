const OutboundCrossClusterSearchConnectionStatusCode = @import("outbound_cross_cluster_search_connection_status_code.zig").OutboundCrossClusterSearchConnectionStatusCode;

/// Specifies the connection status of an outbound cross-cluster search
/// connection.
pub const OutboundCrossClusterSearchConnectionStatus = struct {
    /// Specifies verbose information for the outbound connection status.
    message: ?[]const u8,

    /// The state code for outbound connection. This can be one of the following:
    ///
    /// * VALIDATING: The outbound connection request is being validated.
    ///
    /// * VALIDATION_FAILED: Validation failed for the connection request.
    ///
    /// * PENDING_ACCEPTANCE: Outbound connection request is validated and is not
    ///   yet accepted by destination domain owner.
    ///
    /// * PROVISIONING: Outbound connection request is in process.
    ///
    /// * ACTIVE: Outbound connection is active and ready to use.
    ///
    /// * REJECTED: Outbound connection request is rejected by destination domain
    ///   owner.
    ///
    /// * DELETING: Outbound connection deletion is in progress.
    ///
    /// * DELETED: Outbound connection is deleted and cannot be used further.
    status_code: ?OutboundCrossClusterSearchConnectionStatusCode,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
