const AwsFundingUsed = @import("aws_funding_used.zig").AwsFundingUsed;
const Channel = @import("channel.zig").Channel;
const MarketingSource = @import("marketing_source.zig").MarketingSource;

/// An object that contains marketing details for the `Opportunity`.
pub const Marketing = struct {
    /// Indicates if the `Opportunity` is a marketing development fund (MDF) funded
    /// activity.
    aws_funding_used: ?AwsFundingUsed = null,

    /// Specifies the `Opportunity` marketing campaign code. The Amazon Web Services
    /// campaign code is a reference to specific marketing initiatives, promotions,
    /// or activities. This field captures the identifier used to track and
    /// categorize the `Opportunity` within marketing campaigns. If you don't have a
    /// campaign code, contact your Amazon Web Services point of contact to obtain
    /// one.
    campaign_name: ?[]const u8 = null,

    /// Specifies the `Opportunity`'s channel that the marketing activity is
    /// associated with or was contacted through. This field provides information
    /// about the specific marketing channel that contributed to the generation of
    /// the lead or contact.
    channels: ?[]const Channel = null,

    /// Indicates if the `Opportunity` was sourced from an Amazon Web Services
    /// marketing activity. Use the value `Marketing Activity`. Use `None` if it's
    /// not associated with an Amazon Web Services marketing activity. This field
    /// helps Amazon Web Services track the return on marketing investments and
    /// enables better distribution of marketing budgets among partners.
    source: ?MarketingSource = null,

    /// Specifies the marketing activity use case or purpose that led to the
    /// `Opportunity`'s creation or contact. This field captures the context or
    /// marketing activity's execution's intention and the direct correlation to the
    /// generated opportunity or contact. Must be empty when
    /// `Marketing.AWSFundingUsed = No`.
    ///
    /// Valid values: `AI/ML | Analytics | Application Integration | Blockchain |
    /// Business Applications | Cloud Financial Management | Compute | Containers |
    /// Customer Engagement | Databases | Developer Tools | End User Computing |
    /// Front End Web & Mobile | Game Tech | IoT | Management & Governance | Media
    /// Services | Migration & Transfer | Networking & Content Delivery | Quantum
    /// Technologies | Robotics | Satellite | Security | Serverless | Storage | VR &
    /// AR`
    use_cases: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .aws_funding_used = "AwsFundingUsed",
        .campaign_name = "CampaignName",
        .channels = "Channels",
        .source = "Source",
        .use_cases = "UseCases",
    };
};
