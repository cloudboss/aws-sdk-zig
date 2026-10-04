const PayerResponsibilityType = @import("payer_responsibility_type.zig").PayerResponsibilityType;
const PayerResponsibilityScope = @import("payer_responsibility_scope.zig").PayerResponsibilityScope;

/// Describes a payer responsibility setting for a VPC endpoint.
pub const PayerResponsibilityEntry = struct {
    /// The Amazon Web Services account to which the usage is charged.
    payer_responsibility_type: ?PayerResponsibilityType = null,

    /// The scope of usage/charges.
    scope: ?PayerResponsibilityScope = null,
};
