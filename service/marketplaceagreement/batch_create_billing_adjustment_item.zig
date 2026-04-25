/// A successfully created billing adjustment request item.
pub const BatchCreateBillingAdjustmentItem = struct {
    /// The unique identifier of the created billing adjustment request.
    billing_adjustment_request_id: []const u8,

    /// The client token provided in the corresponding request entry.
    client_token: []const u8,

    pub const json_field_names = .{
        .billing_adjustment_request_id = "billingAdjustmentRequestId",
        .client_token = "clientToken",
    };
};
