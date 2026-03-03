const PhoneNumberWorkflowStatus = @import("phone_number_workflow_status.zig").PhoneNumberWorkflowStatus;

/// The status of the phone number.
///
/// * `CLAIMED` means the previous
///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html) or [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html)
/// operation succeeded.
///
/// * `IN_PROGRESS` means a
///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html), [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html), or [UpdatePhoneNumberMetadata](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumberMetadata.html) operation is still in progress and has not yet completed. You can call [DescribePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribePhoneNumber.html) at
/// a later time to verify if the previous operation has completed.
///
/// * `FAILED` indicates that the previous
///   [ClaimPhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_ClaimPhoneNumber.html) or [UpdatePhoneNumber](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdatePhoneNumber.html)
/// operation has failed. It will include a message indicating the failure
/// reason. A common reason for a failure may be
/// that the `TargetArn` value you are claiming or updating a phone number to
/// has reached its limit of total
/// claimed numbers. If you received a `FAILED` status from a `ClaimPhoneNumber`
/// API call, you
/// have one day to retry claiming the phone number before the number is
/// released back to the inventory for other
/// customers to claim.
pub const PhoneNumberStatus = struct {
    /// The status message.
    message: ?[]const u8 = null,

    /// The status.
    status: ?PhoneNumberWorkflowStatus = null,

    pub const json_field_names = .{
        .message = "Message",
        .status = "Status",
    };
};
