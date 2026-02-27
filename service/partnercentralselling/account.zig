const Address = @import("address.zig").Address;
const Industry = @import("industry.zig").Industry;

/// Specifies the `Customer`'s account details associated with the
/// `Opportunity`.
pub const Account = struct {
    /// Specifies the end `Customer`'s address details associated with the
    /// `Opportunity`.
    address: ?Address,

    /// Specifies the `Customer` Amazon Web Services account ID associated with the
    /// `Opportunity`.
    aws_account_id: ?[]const u8,

    /// Specifies the end `Customer`'s company name associated with the
    /// `Opportunity`.
    company_name: []const u8,

    /// Indicates the `Customer` DUNS number, if available.
    duns: ?[]const u8,

    /// Specifies the industry the end `Customer` belongs to that's associated with
    /// the `Opportunity`. It refers to the category or sector where the customer's
    /// business operates. This is a required field.
    industry: ?Industry,

    /// Specifies the end `Customer`'s industry associated with the `Opportunity`,
    /// when the selected value in the `Industry` field is `Other`.
    other_industry: ?[]const u8,

    /// Specifies the end customer's company website URL associated with the
    /// `Opportunity`. This value is crucial to map the customer within the Amazon
    /// Web Services CRM system. This field is required in all cases except when the
    /// opportunity is related to national security.
    website_url: ?[]const u8,

    pub const json_field_names = .{
        .address = "Address",
        .aws_account_id = "AwsAccountId",
        .company_name = "CompanyName",
        .duns = "Duns",
        .industry = "Industry",
        .other_industry = "OtherIndustry",
        .website_url = "WebsiteUrl",
    };
};
