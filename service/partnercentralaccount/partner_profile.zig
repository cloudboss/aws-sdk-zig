const IndustrySegment = @import("industry_segment.zig").IndustrySegment;
const LocalizedContent = @import("localized_content.zig").LocalizedContent;
const PrimarySolutionType = @import("primary_solution_type.zig").PrimarySolutionType;

/// Contains comprehensive profile information for a partner including
/// public-facing details.
pub const PartnerProfile = struct {
    /// A description of the partner's business, services, and capabilities.
    description: []const u8,

    /// The public display name for the partner organization.
    display_name: []const u8,

    /// The industry segments or verticals that the partner serves.
    industry_segments: []const IndustrySegment,

    /// A list of localized content versions for different languages and regions.
    localized_contents: ?[]const LocalizedContent,

    /// The URL to the partner's logo image.
    logo_url: []const u8,

    /// The primary type of solution or service the partner provides.
    primary_solution_type: PrimarySolutionType,

    /// The unique identifier of the partner profile.
    profile_id: ?[]const u8,

    /// The source locale used for automatic translation of profile content.
    translation_source_locale: []const u8,

    /// The partner's primary website URL.
    website_url: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .industry_segments = "IndustrySegments",
        .localized_contents = "LocalizedContents",
        .logo_url = "LogoUrl",
        .primary_solution_type = "PrimarySolutionType",
        .profile_id = "ProfileId",
        .translation_source_locale = "TranslationSourceLocale",
        .website_url = "WebsiteUrl",
    };
};
