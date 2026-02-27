const Category = @import("category.zig").Category;

/// The policy that specifies which URLs end users are allowed to access or
/// which URLs or domain categories they are restricted from accessing for
/// enhanced security.
pub const WebContentFilteringPolicy = struct {
    /// URLs and domains that are always accessible to end users.
    allowed_urls: ?[]const []const u8,

    /// Categories of websites that are blocked on the end user’s browsers.
    blocked_categories: ?[]const Category,

    /// URLs and domains that end users cannot access.
    blocked_urls: ?[]const []const u8,

    pub const json_field_names = .{
        .allowed_urls = "allowedUrls",
        .blocked_categories = "blockedCategories",
        .blocked_urls = "blockedUrls",
    };
};
