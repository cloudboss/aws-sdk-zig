const Industries = @import("industries.zig").Industries;

/// Additional tax information associated with your TRN in Turkey.
pub const TurkeyAdditionalInfo = struct {
    /// The industry information that tells the Tax Settings API if you're subject
    /// to additional
    /// withholding taxes. This information required for business-to-business (B2B)
    /// customers. This
    /// information is conditionally mandatory for B2B customers who are subject to
    /// KDV tax.
    industries: ?Industries = null,

    /// The Registered Electronic Mail (REM) that is used to send notarized
    /// communication. This parameter is optional for business-to-business (B2B) and
    /// business-to-government (B2G) customers. It's not required for
    /// business-to-consumer (B2C) customers.
    kep_email_id: ?[]const u8 = null,

    /// Secondary tax ID (“harcama birimi VKN”si”). If one isn't provided, we will
    /// use your VKN as the secondary ID.
    secondary_tax_id: ?[]const u8 = null,

    /// The tax office where you're registered. You can enter this information as a
    /// string. The Tax Settings API will add this information to your invoice. This
    /// parameter is required for business-to-business (B2B) and
    /// business-to-government customers. It's not required for business-to-consumer
    /// (B2C) customers.
    tax_office: ?[]const u8 = null,

    pub const json_field_names = .{
        .industries = "industries",
        .kep_email_id = "kepEmailId",
        .secondary_tax_id = "secondaryTaxId",
        .tax_office = "taxOffice",
    };
};
