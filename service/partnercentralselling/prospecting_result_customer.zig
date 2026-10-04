const CountryCode = @import("country_code.zig").CountryCode;
const Industry = @import("industry.zig").Industry;

/// Contains detailed information about the prospected customer account,
/// including company identifiers, geographic classification, industry
/// segmentation, and program eligibility.
pub const ProspectingResultCustomer = struct {
    /// The name of the prospected customer account.
    account_name: ?[]const u8 = null,

    /// The company size classification of the prospected customer account.
    company_size: ?[]const u8 = null,

    /// The country code of the prospected customer account.
    country: ?CountryCode = null,

    /// A list of AWS Greenfield programs that the prospected customer is eligible
    /// for. Use this list to identify relevant go-to-market opportunities.
    eligible_programs: ?[]const []const u8 = null,

    /// The geographic region classification of the prospected customer account.
    geo: ?[]const u8 = null,

    /// The industry classification of the prospected customer account.
    industry: ?Industry = null,

    /// A summary of publicly available information about the prospected customer.
    /// The system uses this summary to generate customer insights and inform
    /// engagement strategies.
    public_profile_summary: ?[]const u8 = null,

    /// The specific region of the prospected customer account.
    region: ?[]const u8 = null,

    /// The market segment classification of the prospected customer account.
    segment: ?[]const u8 = null,

    /// The sub-industry classification of the prospected customer account. This
    /// provides more granular categorization within the primary industry.
    sub_industry: ?[]const u8 = null,

    /// The subregion classification of the prospected customer account.
    sub_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .company_size = "CompanySize",
        .country = "Country",
        .eligible_programs = "EligiblePrograms",
        .geo = "Geo",
        .industry = "Industry",
        .public_profile_summary = "PublicProfileSummary",
        .region = "Region",
        .segment = "Segment",
        .sub_industry = "SubIndustry",
        .sub_region = "SubRegion",
    };
};
