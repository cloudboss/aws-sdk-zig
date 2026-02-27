const InboundConnectionStatusCode = @import("inbound_connection_status_code.zig").InboundConnectionStatusCode;

/// The status of an inbound cross-cluster connection for OpenSearch Service.
pub const InboundConnectionStatus = struct {
    /// Information about the connection.
    message: ?[]const u8,

    /// The status code for the connection. Can be one of the following:
    ///
    /// * **PENDING_ACCEPTANCE** - Inbound connection is not yet
    /// accepted by the remote domain owner.
    ///
    /// * **APPROVED**: Inbound connection is pending acceptance by the
    /// remote domain owner.
    ///
    /// * **PROVISIONING**: Inbound connection is being
    /// provisioned.
    ///
    /// * **ACTIVE**: Inbound connection is active and ready to
    /// use.
    ///
    /// * **REJECTING**: Inbound connection rejection is in
    /// process.
    ///
    /// * **REJECTED**: Inbound connection is rejected.
    ///
    /// * **DELETING**: Inbound connection deletion is in
    /// progress.
    ///
    /// * **DELETED**: Inbound connection is deleted and can no longer
    /// be used.
    status_code: ?InboundConnectionStatusCode,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
