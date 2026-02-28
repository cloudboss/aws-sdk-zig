const CustomerAgreementState = @import("customer_agreement_state.zig").CustomerAgreementState;
const AgreementType = @import("agreement_type.zig").AgreementType;

/// Summary for customer-agreement resource.
pub const CustomerAgreementSummary = struct {
    /// Terms required to accept the agreement resource.
    acceptance_terms: ?[]const []const u8,

    /// ARN of the agreement resource the customer-agreement resource represents.
    agreement_arn: ?[]const u8,

    /// ARN of the customer-agreement resource.
    arn: ?[]const u8,

    /// AWS account Id that owns the resource.
    aws_account_id: ?[]const u8,

    /// Description of the resource.
    description: ?[]const u8,

    /// Timestamp indicating when the agreement was terminated.
    effective_end: ?i64,

    /// Timestamp indicating when the agreement became effective.
    effective_start: ?i64,

    /// Identifier of the customer-agreement resource.
    id: ?[]const u8,

    /// Name of the customer-agreement resource.
    name: ?[]const u8,

    /// ARN of the organization that owns the resource.
    organization_arn: ?[]const u8,

    /// State of the resource.
    state: ?CustomerAgreementState,

    /// Terms required to terminate the customer-agreement resource.
    terminate_terms: ?[]const []const u8,

    /// Type of the customer-agreement resource.
    @"type": ?AgreementType,

    pub const json_field_names = .{
        .acceptance_terms = "acceptanceTerms",
        .agreement_arn = "agreementArn",
        .arn = "arn",
        .aws_account_id = "awsAccountId",
        .description = "description",
        .effective_end = "effectiveEnd",
        .effective_start = "effectiveStart",
        .id = "id",
        .name = "name",
        .organization_arn = "organizationArn",
        .state = "state",
        .terminate_terms = "terminateTerms",
        .@"type" = "type",
    };
};
