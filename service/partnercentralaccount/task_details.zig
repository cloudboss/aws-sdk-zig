const IndustrySegment = @import("industry_segment.zig").IndustrySegment;
const LocalizedContent = @import("localized_content.zig").LocalizedContent;
const PrimarySolutionType = @import("primary_solution_type.zig").PrimarySolutionType;

/// Contains detailed information about a profile update task including the
/// changes to be made.
pub const TaskDetails = struct {
    /// The updated description for the partner profile.
    description: []const u8,

    /// The updated display name for the partner profile.
    display_name: []const u8,

    /// The updated industry segments for the partner profile.
    industry_segments: []const IndustrySegment,

    /// The updated localized content for the partner profile.
    localized_contents: ?[]const LocalizedContent = null,

    /// The updated logo URL for the partner profile.
    logo_url: []const u8,

    /// The updated primary solution type for the partner profile.
    primary_solution_type: PrimarySolutionType,

    /// The updated translation source locale for the partner profile.
    translation_source_locale: []const u8,

    /// The updated website URL for the partner profile.
    website_url: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .industry_segments = "IndustrySegments",
        .localized_contents = "LocalizedContents",
        .logo_url = "LogoUrl",
        .primary_solution_type = "PrimarySolutionType",
        .translation_source_locale = "TranslationSourceLocale",
        .website_url = "WebsiteUrl",
    };
};
