const EstimatedTaxes = @import("estimated_taxes.zig").EstimatedTaxes;
const ExpectedCharge = @import("expected_charge.zig").ExpectedCharge;
const InvoicingEntity = @import("invoicing_entity.zig").InvoicingEntity;
const ItemizedCharge = @import("itemized_charge.zig").ItemizedCharge;

/// The `ChargeSummary` provides a detailed breakdown of charges that are
/// associated with an agreement request. This is applicable only when a request
/// is created for a `PurchaseAgreement`.
///
/// Tax and invoicing fields (such as `estimatedTaxes`, `amountAfterTax`,
/// `newAgreementValueAfterTax`, and `invoicingEntity`) are returned on a
/// best-effort basis and do not cause the request to fail if unavailable.
///
/// A `null` tax amount can have two meanings:
///
/// * Tax estimation was unavailable at the time of the request.
/// * The charge timing is `BILLING_PERIOD`, so the charge amount is not
///   determined at request time. In this case, the tax breakdown may still
///   include the tax `rate` and `type`.
pub const ChargeSummary = struct {
    /// The three-letter currency code for all charges (e.g., USD).
    currency_code: ?[]const u8 = null,

    /// Provides an aggregated view of estimated tax information for the agreement.
    estimated_taxes: ?EstimatedTaxes = null,

    /// A list of expected charges for the agreement request.
    expected_charges: ?[]const ExpectedCharge = null,

    /// The entity responsible for issuing the invoice.
    invoicing_entity: ?InvoicingEntity = null,

    /// An itemized list of charges for the agreement request.
    itemized_charges: ?[]const ItemizedCharge = null,

    /// The total value of the agreement, which includes any amendments.
    new_agreement_value: ?[]const u8 = null,

    /// Expected new agreement value after estimated taxes are applied.
    new_agreement_value_after_tax: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .estimated_taxes = "estimatedTaxes",
        .expected_charges = "expectedCharges",
        .invoicing_entity = "invoicingEntity",
        .itemized_charges = "itemizedCharges",
        .new_agreement_value = "newAgreementValue",
        .new_agreement_value_after_tax = "newAgreementValueAfterTax",
    };
};
