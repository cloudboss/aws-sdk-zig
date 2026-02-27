const ContentCategoryType = @import("content_category_type.zig").ContentCategoryType;
const DateRangeType = @import("date_range_type.zig").DateRangeType;
const SearchPrincipalType = @import("search_principal_type.zig").SearchPrincipalType;
const SearchResourceType = @import("search_resource_type.zig").SearchResourceType;
const SearchCollectionType = @import("search_collection_type.zig").SearchCollectionType;
const LongRangeType = @import("long_range_type.zig").LongRangeType;
const LanguageCodeType = @import("language_code_type.zig").LanguageCodeType;

/// Filters results based on entity metadata.
pub const Filters = struct {
    /// Filter based on resource’s path.
    ancestor_ids: ?[]const []const u8,

    /// Filters by content category.
    content_categories: ?[]const ContentCategoryType,

    /// Filter based on resource’s creation timestamp.
    created_range: ?DateRangeType,

    /// Filter by labels using exact match.
    labels: ?[]const []const u8,

    /// Filter based on resource’s modified timestamp.
    modified_range: ?DateRangeType,

    /// Filter based on UserIds or GroupIds.
    principals: ?[]const SearchPrincipalType,

    /// Filters based on entity type.
    resource_types: ?[]const SearchResourceType,

    /// Filter based on file groupings.
    search_collection_types: ?[]const SearchCollectionType,

    /// Filter based on size (in bytes).
    size_range: ?LongRangeType,

    /// Filters by the locale of the content or comment.
    text_locales: ?[]const LanguageCodeType,

    pub const json_field_names = .{
        .ancestor_ids = "AncestorIds",
        .content_categories = "ContentCategories",
        .created_range = "CreatedRange",
        .labels = "Labels",
        .modified_range = "ModifiedRange",
        .principals = "Principals",
        .resource_types = "ResourceTypes",
        .search_collection_types = "SearchCollectionTypes",
        .size_range = "SizeRange",
        .text_locales = "TextLocales",
    };
};
