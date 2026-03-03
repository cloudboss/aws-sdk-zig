/// Additional tax information associated with your TRN in Canada .
pub const CanadaAdditionalInfo = struct {
    /// The Quebec Sales Tax ID number. Leave blank if you do not have a Quebec
    /// Sales Tax ID number.
    canada_quebec_sales_tax_number: ?[]const u8 = null,

    /// Manitoba Retail Sales Tax ID number. Customers purchasing Amazon Web
    /// Services services for resale in Manitoba must provide a valid Retail Sales
    /// Tax ID number for Manitoba. Leave this blank if you do not have a Retail
    /// Sales Tax ID number in Manitoba or are not purchasing Amazon Web Services
    /// services for resale.
    canada_retail_sales_tax_number: ?[]const u8 = null,

    /// The value for this parameter must be `true` if the
    /// `provincialSalesTaxId` value is provided for a TRN in British Columbia,
    /// Saskatchewan, or Manitoba provinces.
    ///
    /// To claim a provincial sales tax (PST) and retail sales tax (RST) reseller
    /// exemption, you
    /// must confirm that purchases from this account were made for resale.
    /// Otherwise, remove the PST
    /// or RST number from the `provincialSalesTaxId` parameter from your request.
    is_reseller_account: ?bool = null,

    /// The provincial sales tax ID for your TRN in Canada. This parameter can
    /// represent the
    /// following:
    ///
    /// * Provincial sales tax ID number for British Columbia and Saskatchewan
    ///   provinces
    ///
    /// * Manitoba retail sales tax ID number for Manitoba province
    ///
    /// * Quebec sales tax ID number for Quebec province
    ///
    /// The Tax Setting API only accepts this parameter if the TRN is specified for
    /// the previous
    /// provinces. For other provinces, the Tax Settings API doesn't accept this
    /// parameter.
    provincial_sales_tax_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .canada_quebec_sales_tax_number = "canadaQuebecSalesTaxNumber",
        .canada_retail_sales_tax_number = "canadaRetailSalesTaxNumber",
        .is_reseller_account = "isResellerAccount",
        .provincial_sales_tax_id = "provincialSalesTaxId",
    };
};
