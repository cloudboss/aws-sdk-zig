const PaymentsAuthorizerType = @import("payments_authorizer_type.zig").PaymentsAuthorizerType;
const PaymentManagerStatus = @import("payment_manager_status.zig").PaymentManagerStatus;

/// Contains summary information about a payment manager.
pub const PaymentManagerSummary = struct {
    /// The type of authorizer used by the payment manager.
    ///
    /// * `CUSTOM_JWT` - Authorize with a bearer token.
    /// * `AWS_IAM` - Authorize with your Amazon Web Services IAM credentials.
    authorizer_type: PaymentsAuthorizerType,

    /// The timestamp when the payment manager was created.
    created_at: ?i64 = null,

    /// The description of the payment manager.
    description: ?[]const u8 = null,

    /// The timestamp when the payment manager was last updated.
    last_updated_at: i64,

    /// The name of the payment manager.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the payment manager.
    payment_manager_arn: []const u8,

    /// The unique identifier of the payment manager.
    payment_manager_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the payment
    /// manager.
    role_arn: []const u8,

    /// The current status of the payment manager. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentManagerStatus,

    pub const json_field_names = .{
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .payment_manager_arn = "paymentManagerArn",
        .payment_manager_id = "paymentManagerId",
        .role_arn = "roleArn",
        .status = "status",
    };
};
