const BenefitAllocationStatus = @import("benefit_allocation_status.zig").BenefitAllocationStatus;
const MonetaryValue = @import("monetary_value.zig").MonetaryValue;

/// Represents an AWS credit code that can be applied to an AWS account for
/// billing purposes.
pub const CreditCode = struct {
    /// The AWS account ID that the credit code is associated with or can be applied
    /// to.
    aws_account_id: []const u8,

    /// The actual credit code string that can be redeemed in the AWS billing
    /// console.
    aws_credit_code: []const u8,

    /// The timestamp when the credit code expires and can no longer be redeemed.
    expires_at: i64,

    /// The timestamp when the credit code was issued.
    issued_at: i64,

    /// The current status of the credit code (e.g., active, redeemed, expired).
    status: BenefitAllocationStatus,

    /// The monetary value of the credit code.
    value: MonetaryValue,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .aws_credit_code = "AwsCreditCode",
        .expires_at = "ExpiresAt",
        .issued_at = "IssuedAt",
        .status = "Status",
        .value = "Value",
    };
};
