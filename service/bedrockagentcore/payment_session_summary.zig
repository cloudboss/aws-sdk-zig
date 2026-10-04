/// Summary information about a payment session.
pub const PaymentSessionSummary = struct {
    /// The timestamp when the session was created.
    created_at: i64,

    /// The session expiry time in minutes.
    expiry_time_in_minutes: i32,

    /// The ARN of the payment manager that owns this session.
    payment_manager_arn: []const u8,

    /// The unique identifier of the payment session.
    payment_session_id: []const u8,

    /// The timestamp when the session was last updated.
    updated_at: i64,

    /// The user ID associated with this session.
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
