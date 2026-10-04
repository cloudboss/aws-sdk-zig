const LeadAddress = @import("lead_address.zig").LeadAddress;

/// Contains detailed information about the customer associated with the lead,
/// including company details, industry classification, and AWS maturity level.
/// This information helps qualify and categorize the lead for appropriate
/// engagement strategies.
pub const LeadCustomer = struct {
    /// The address information for the lead customer.
    address: ?LeadAddress = null,

    /// Indicates the customer's level of experience and adoption with AWS services.
    /// This assessment helps determine the appropriate engagement approach and
    /// solution complexity.
    aws_maturity: ?[]const u8 = null,

    /// The name of the lead customer's company. This field is essential for
    /// identifying and tracking the customer organization associated with the lead.
    company_name: []const u8,

    /// Specifies the industry sector to which the lead customer's company belongs.
    /// This categorization helps in understanding the customer's business context
    /// and tailoring appropriate solutions.
    industry: ?[]const u8 = null,

    /// Specifies the market segment classification of the lead customer, such as
    /// enterprise, mid-market, or small business. This segmentation helps in
    /// targeting appropriate solutions and engagement strategies.
    market_segment: ?[]const u8 = null,

    /// The website URL of the lead customer's company. This provides additional
    /// context about the customer organization and helps verify company legitimacy
    /// and size.
    website_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "Address",
        .aws_maturity = "AwsMaturity",
        .company_name = "CompanyName",
        .industry = "Industry",
        .market_segment = "MarketSegment",
        .website_url = "WebsiteUrl",
    };
};
