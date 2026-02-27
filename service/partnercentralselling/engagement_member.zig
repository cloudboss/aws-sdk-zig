/// Engagement members are the participants in an Engagement, which is likely a
/// collaborative project or business opportunity within the AWS partner
/// network. Members can be different partner organizations or AWS accounts that
/// are working together on a specific engagement.
///
/// Each member is represented by their AWS Account ID, Company Name, and
/// associated details. Members have a status within the Engagement (PENDING,
/// ACCEPTED, REJECTED, or WITHDRAWN), indicating their current state of
/// participation. Only existing members of an Engagement can view the list of
/// other members. This implies a level of privacy and access control within the
/// Engagement structure.
pub const EngagementMember = struct {
    /// This is the unique identifier for the AWS account associated with the member
    /// organization. It's used for AWS-related operations and identity
    /// verification.
    account_id: ?[]const u8,

    /// The official name of the member's company or organization.
    company_name: ?[]const u8,

    /// The URL of the member company's website. This offers a way to find more
    /// information about the member organization and serves as an additional
    /// identifier.
    website_url: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .company_name = "CompanyName",
        .website_url = "WebsiteUrl",
    };
};
