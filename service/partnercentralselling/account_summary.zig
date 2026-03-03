const AddressSummary = @import("address_summary.zig").AddressSummary;
const Industry = @import("industry.zig").Industry;

/// An object that contains an `Account`'s subset of fields.
pub const AccountSummary = struct {
    /// Specifies the end `Customer`'s address details associated with the
    /// `Opportunity`.
    address: ?AddressSummary = null,

    /// Specifies the end `Customer`'s company name associated with the
    /// `Opportunity`.
    company_name: []const u8,

    /// Specifies which industry the end `Customer` belongs to associated with the
    /// `Opportunity`. It refers to the category or sector that the customer's
    /// business operates in.
    ///
    /// To submit a value outside the picklist, use `Other`.
    ///
    /// Conditionally mandatory if `Other` is selected for Industry Vertical in
    /// LOVs.
    industry: ?Industry = null,

    /// Specifies the end `Customer`'s industry associated with the ` Opportunity`,
    /// when the selected value in the `Industry` field is `Other`. This field is
    /// relevant when the customer's industry doesn't fall under the predefined
    /// picklist values and requires a custom description.
    other_industry: ?[]const u8 = null,

    /// Specifies the end customer's company website URL associated with the
    /// `Opportunity`. This value is crucial to map the customer within the Amazon
    /// Web Services CRM system.
    website_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "Address",
        .company_name = "CompanyName",
        .industry = "Industry",
        .other_industry = "OtherIndustry",
        .website_url = "WebsiteUrl",
    };
};
