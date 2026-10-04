const PayerResponsibilityPayer = @import("payer_responsibility_payer.zig").PayerResponsibilityPayer;
const PayerResponsibilityScope = @import("payer_responsibility_scope.zig").PayerResponsibilityScope;

/// Specifies which account pays for a category of charges on a VPC endpoint
/// association.
pub const PayerResponsibilityEntry = struct {
    /// The account that pays this category of charges. `VpcEndpointAccount` owns
    /// the VPC endpoint. `ResourceGatewayAccount` owns the resource gateway.
    payer_responsibility_type: ?PayerResponsibilityPayer = null,

    /// The category of charges that this entry applies to. `ResourceGatewayCharges`
    /// covers the resource gateway's data processing charge.
    scope: ?PayerResponsibilityScope = null,

    pub const json_field_names = .{
        .payer_responsibility_type = "payerResponsibilityType",
        .scope = "scope",
    };
};
