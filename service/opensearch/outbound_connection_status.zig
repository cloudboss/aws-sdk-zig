const OutboundConnectionStatusCode = @import("outbound_connection_status_code.zig").OutboundConnectionStatusCode;

/// The status of an outbound cross-cluster connection.
pub const OutboundConnectionStatus = struct {
    /// Verbose information for the outbound connection.
    message: ?[]const u8 = null,

    /// The status code for the outbound connection. Can be one of the following:
    ///
    /// * **VALIDATING** - The outbound connection request
    /// is being validated.
    ///
    /// * **VALIDATION_FAILED** - Validation failed for the
    /// connection request.
    ///
    /// * **PENDING_ACCEPTANCE**: Outbound connection
    /// request is validated and is not yet accepted by the remote domain owner.
    ///
    /// * **APPROVED** - Outbound connection has been
    /// approved by the remote domain owner for getting provisioned.
    ///
    /// * **PROVISIONING** - Outbound connection request is
    /// in process.
    ///
    /// * **ACTIVE** - Outbound connection is active and
    /// ready to use.
    ///
    /// * **REJECTING** - Outbound connection rejection by
    /// remote domain owner is in progress.
    ///
    /// * **REJECTED** - Outbound connection request is
    /// rejected by remote domain owner.
    ///
    /// * **DELETING** - Outbound connection deletion is in
    /// progress.
    ///
    /// * **DELETED** - Outbound connection is deleted and
    /// can no longer be used.
    status_code: ?OutboundConnectionStatusCode = null,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
