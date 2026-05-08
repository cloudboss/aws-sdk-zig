const PaymentConnectorStatus = @import("payment_connector_status.zig").PaymentConnectorStatus;
const PaymentConnectorType = @import("payment_connector_type.zig").PaymentConnectorType;

/// Contains summary information about a payment connector.
pub const PaymentConnectorSummary = struct {
    /// The timestamp when the payment connector was last updated.
    last_updated_at: i64,

    /// The name of the payment connector.
    name: []const u8,

    /// The unique identifier of the payment connector.
    payment_connector_id: []const u8,

    /// The current status of the payment connector. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentConnectorStatus,

    /// The type of the payment connector, which determines the payment provider
    /// integration.
    @"type": PaymentConnectorType,

    pub const json_field_names = .{
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .payment_connector_id = "paymentConnectorId",
        .status = "status",
        .@"type" = "type",
    };
};
