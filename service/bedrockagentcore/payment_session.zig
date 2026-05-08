const AvailableLimits = @import("available_limits.zig").AvailableLimits;
const SessionLimits = @import("session_limits.zig").SessionLimits;

/// Payment manager session
pub const PaymentSession = struct {
    /// The available limits for this session after accounting for processed
    /// payments.
    available_limits: ?AvailableLimits = null,

    /// The timestamp when this payment session was created.
    created_at: i64,

    /// The session expiry time in minutes.
    expiry_time_in_minutes: i32,

    /// The spending limits for this session.
    limits: ?SessionLimits = null,

    /// The ARN of the payment manager that owns this session.
    payment_manager_arn: []const u8,

    /// The unique identifier for this payment session.
    payment_session_id: []const u8,

    /// The timestamp when this payment session was last updated.
    updated_at: i64,

    /// The user ID associated with this payment session.
    user_id: []const u8,

    pub const json_field_names = .{
        .available_limits = "availableLimits",
        .created_at = "createdAt",
        .expiry_time_in_minutes = "expiryTimeInMinutes",
        .limits = "limits",
        .payment_manager_arn = "paymentManagerArn",
        .payment_session_id = "paymentSessionId",
        .updated_at = "updatedAt",
        .user_id = "userId",
    };
};
