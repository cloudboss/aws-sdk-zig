const CountryCode = @import("country_code.zig").CountryCode;
const Industry = @import("industry.zig").Industry;
const MarketSegment = @import("market_segment.zig").MarketSegment;

/// Contains customer information included in a lead invitation payload. This
/// structure provides essential details about the customer to help partners
/// evaluate the lead opportunity and determine their interest in engagement.
pub const LeadInvitationCustomer = struct {
    /// Indicates the customer's level of experience and adoption with AWS services.
    /// This assessment helps partners understand the customer's cloud maturity and
    /// tailor their engagement approach accordingly.
    aws_maturity: ?[]const u8,

    /// The name of the customer company associated with the lead invitation. This
    /// field identifies the target organization for the lead engagement
    /// opportunity.
    company_name: []const u8,

    /// The country code indicating the geographic location of the customer company.
    /// This information helps partners understand regional requirements and assess
    /// their ability to serve the customer effectively.
    country_code: CountryCode,

    /// Specifies the industry sector of the customer company associated with the
    /// lead invitation. This categorization helps partners understand the
    /// customer's business context and assess solution fit.
    industry: ?Industry,

    /// Specifies the market segment classification of the customer, such as
    /// enterprise, mid-market, or small business. This segmentation helps partners
    /// determine the appropriate solution complexity and engagement strategy.
    market_segment: ?MarketSegment,

    /// The website URL of the customer company. This provides additional context
    /// about the customer organization and helps partners verify company details
    /// and assess business size and legitimacy.
    website_url: ?[]const u8,

    pub const json_field_names = .{
        .aws_maturity = "AwsMaturity",
        .company_name = "CompanyName",
        .country_code = "CountryCode",
        .industry = "Industry",
        .market_segment = "MarketSegment",
        .website_url = "WebsiteUrl",
    };
};
