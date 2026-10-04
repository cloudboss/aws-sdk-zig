const ApplicationType = @import("application_type.zig").ApplicationType;
const CreditSharingType = @import("credit_sharing_type.zig").CreditSharingType;
const CreditStatus = @import("credit_status.zig").CreditStatus;
const Amount = @import("amount.zig").Amount;

/// Detailed information about an Amazon Web Services credit, including its
/// identifier, type, monetary amounts, applicable products, sharing
/// configuration, and current enabled status.
pub const CreditData = struct {
    /// Whether the owning account has account-level credit sharing turned on.
    account_has_credit_sharing_enabled: ?bool = null,

    /// The Amazon Web Services account ID that owns the credit.
    account_id: []const u8,

    /// The names of Amazon Web Services services this credit applies to.
    applicable_product_names: ?[]const []const u8 = null,

    /// When the credit is applied during bill computation. Valid values:
    /// `BEFORE_CROSS_SERVICE_DISCOUNTS`, `AFTER_DISCOUNTS`.
    application_type: ?ApplicationType = null,

    /// The Amazon Resource Name (ARN) of the Cost Category controlling the credit's
    /// sharing scope. Present only when `creditSharingType` is
    /// `COST_CATEGORY_RULE`.
    cost_category_arn: ?[]const u8 = null,

    /// The display configuration for the credit in the Amazon Web Services Billing
    /// console.
    credit_console_visibility: ?[]const u8 = null,

    /// The unique identifier for the credit.
    credit_id: []const u8,

    /// The sharing configuration for the credit. Valid values: `DEFAULT`,
    /// `DISABLED`, `CUSTOM`, `COST_CATEGORY_RULE`.
    credit_sharing_type: ?CreditSharingType = null,

    /// Whether the credit participates in billing runs. Valid values: `ENABLED`,
    /// `DISABLED`.
    credit_status: ?CreditStatus = null,

    /// The type of credit. Examples: `Promotion`, `Refund`, `TrueUp`.
    credit_type: []const u8,

    /// A human-readable description of the credit.
    description: []const u8,

    /// The date the credit expires, as Unix epoch seconds.
    end_date: ?i64 = null,

    /// The estimated remaining balance, including in-flight (open) bills that have
    /// not yet been finalized.
    estimated_amount: ?Amount = null,

    /// The date the credit balance reached zero, as Unix epoch seconds.
    exhaust_date: ?i64 = null,

    /// The initial amount of the credit when it was issued.
    initial_amount: Amount,

    /// Restricts which purchase types this credit applies to. When `null` or
    /// omitted, the credit applies to all purchase types.
    purchase_type_applications: ?[]const []const u8 = null,

    /// The unused balance of the credit.
    remaining_amount: Amount,

    /// The rule name within the Cost Category. Present only when
    /// `creditSharingType` is `COST_CATEGORY_RULE`.
    rule_name: ?[]const u8 = null,

    /// The Amazon Web Services account IDs entitled to apply this credit.
    shareable_accounts: ?[]const []const u8 = null,

    /// The date the credit becomes valid, as Unix epoch seconds.
    start_date: i64,

    pub const json_field_names = .{
        .account_has_credit_sharing_enabled = "accountHasCreditSharingEnabled",
        .account_id = "accountId",
        .applicable_product_names = "applicableProductNames",
        .application_type = "applicationType",
        .cost_category_arn = "costCategoryArn",
        .credit_console_visibility = "creditConsoleVisibility",
        .credit_id = "creditId",
        .credit_sharing_type = "creditSharingType",
        .credit_status = "creditStatus",
        .credit_type = "creditType",
        .description = "description",
        .end_date = "endDate",
        .estimated_amount = "estimatedAmount",
        .exhaust_date = "exhaustDate",
        .initial_amount = "initialAmount",
        .purchase_type_applications = "purchaseTypeApplications",
        .remaining_amount = "remainingAmount",
        .rule_name = "ruleName",
        .shareable_accounts = "shareableAccounts",
        .start_date = "startDate",
    };
};
