const OperationStatus = @import("operation_status.zig").OperationStatus;
const StatusFlag = @import("status_flag.zig").StatusFlag;
const OperationType = @import("operation_type.zig").OperationType;

/// OperationSummary includes the following elements.
pub const OperationSummary = struct {
    /// Name of the domain.
    domain_name: ?[]const u8,

    /// The date when the last change was made in Unix time format and Coordinated
    /// Universal
    /// Time (UTC).
    last_updated_date: ?i64,

    /// Message about the operation.
    message: ?[]const u8,

    /// Identifier returned to track the requested action.
    operation_id: ?[]const u8,

    /// The current status of the requested operation in the system.
    status: ?OperationStatus,

    /// Automatically checks whether there are no outstanding operations on domains
    /// that need
    /// customer attention.
    ///
    /// Valid values are:
    ///
    /// * `PENDING_ACCEPTANCE`: The operation is waiting for acceptance from
    /// the account that is receiving the domain.
    ///
    /// * `PENDING_CUSTOMER_ACTION`: The operation is waiting for customer
    /// action, for example, returning an email.
    ///
    /// * `PENDING_AUTHORIZATION`: The operation is waiting for the form of
    /// authorization. For more information, see
    /// [ResendOperationAuthorization](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ResendOperationAuthorization.html).
    ///
    /// * `PENDING_PAYMENT_VERIFICATION`: The operation is waiting for the
    /// payment method to validate.
    ///
    /// * `PENDING_SUPPORT_CASE`: The operation includes a support case and
    /// is waiting for its resolution.
    status_flag: ?StatusFlag,

    /// The date when the request was submitted.
    submitted_date: ?i64,

    /// Type of the action requested.
    type: ?OperationType,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .last_updated_date = "LastUpdatedDate",
        .message = "Message",
        .operation_id = "OperationId",
        .status = "Status",
        .status_flag = "StatusFlag",
        .submitted_date = "SubmittedDate",
        .type = "Type",
    };
};
