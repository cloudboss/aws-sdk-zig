const TaxExemption = @import("tax_exemption.zig").TaxExemption;

/// The tax exemption details.
pub const TaxExemptionDetails = struct {
    /// The indicator if the tax exemption is inherited from the consolidated
    /// billing family management account.
    heritage_obtained_details: ?bool,

    /// The consolidated billing family management account the tax exemption
    /// inherited from.
    heritage_obtained_parent_entity: ?[]const u8,

    /// The reason of the heritage inheritance.
    heritage_obtained_reason: ?[]const u8,

    /// Tax exemptions.
    tax_exemptions: ?[]const TaxExemption,

    pub const json_field_names = .{
        .heritage_obtained_details = "heritageObtainedDetails",
        .heritage_obtained_parent_entity = "heritageObtainedParentEntity",
        .heritage_obtained_reason = "heritageObtainedReason",
        .tax_exemptions = "taxExemptions",
    };
};
