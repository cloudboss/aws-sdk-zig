const CountryCode = @import("country_code.zig").CountryCode;
const Industry = @import("industry.zig").Industry;

/// Contains details about the customer associated with the Engagement
/// Invitation, including company information and industry.
pub const EngagementCustomer = struct {
    /// Represents the name of the customer’s company associated with the Engagement
    /// Invitation. This field is used to identify the customer.
    company_name: []const u8,

    /// Indicates the country in which the customer’s company operates. This field
    /// is useful for understanding regional requirements or compliance needs.
    country_code: CountryCode,

    /// Specifies the industry to which the customer’s company belongs. This field
    /// helps categorize the opportunity based on the customer’s business sector.
    industry: Industry,

    /// Provides the website URL of the customer’s company. This field helps
    /// partners verify the legitimacy and size of the customer organization.
    website_url: []const u8,

    pub const json_field_names = .{
        .company_name = "CompanyName",
        .country_code = "CountryCode",
        .industry = "Industry",
        .website_url = "WebsiteUrl",
    };
};
