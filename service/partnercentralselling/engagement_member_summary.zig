/// The EngagementMemberSummary provides a snapshot of essential information
/// about participants in an AWS Partner Central Engagement. This compact data
/// structure encapsulates key details of each member, facilitating efficient
/// collaboration and management within the Engagement.
pub const EngagementMemberSummary = struct {
    /// The official name of the member's company or organization.
    company_name: ?[]const u8,

    /// The URL of the member company's website. This offers a way to find more
    /// information about the member organization and serves as an additional
    /// identifier.
    website_url: ?[]const u8,

    pub const json_field_names = .{
        .company_name = "CompanyName",
        .website_url = "WebsiteUrl",
    };
};
