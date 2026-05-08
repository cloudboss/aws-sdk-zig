/// Summary of a payment session for list operations
pub const PaymentSessionSummary = struct {
    /// The timestamp when this payment session was created.
    created_at: i64,

    /// The session expiry time in minutes.
    expiry_time_in_minutes: i32,

    /// The ARN of the payment manager that owns this session.
    payment_manager_arn: []const u8,

    /// The unique identifier for this payment session.
    payment_session_id: []const u8,

    /// The timestamp when this payment session was last updated.
    updated_at: i64,

    /// The user ID associated with this payment session.
    user_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .expiry_time_in_minutes = "expiryTimeInMinutes",
        .payment_manager_arn = "paymentManagerArn",
        .payment_session_id = "paymentSessionId",
        .updated_at = "updatedAt",
        .user_id = "userId",
    };
};
