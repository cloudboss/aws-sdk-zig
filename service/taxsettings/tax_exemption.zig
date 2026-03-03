const Authority = @import("authority.zig").Authority;
const EntityExemptionAccountStatus = @import("entity_exemption_account_status.zig").EntityExemptionAccountStatus;
const TaxExemptionType = @import("tax_exemption_type.zig").TaxExemptionType;

/// The tax exemption.
pub const TaxExemption = struct {
    /// The address domain associate with tax exemption.
    authority: Authority,

    /// The tax exemption effective date.
    effective_date: ?i64 = null,

    /// The tax exemption expiration date.
    expiration_date: ?i64 = null,

    /// The tax exemption status.
    status: ?EntityExemptionAccountStatus = null,

    /// The tax exemption recording time in the `TaxSettings` system.
    system_effective_date: ?i64 = null,

    /// The tax exemption type.
    tax_exemption_type: TaxExemptionType,

    pub const json_field_names = .{
        .authority = "authority",
        .effective_date = "effectiveDate",
        .expiration_date = "expirationDate",
        .status = "status",
        .system_effective_date = "systemEffectiveDate",
        .tax_exemption_type = "taxExemptionType",
    };
};
