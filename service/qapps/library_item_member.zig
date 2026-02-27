const Category = @import("category.zig").Category;

/// A library item is a snapshot of an Amazon Q App that can be published so the
/// users in their Amazon Q Apps library can discover it, clone it, and run it.
pub const LibraryItemMember = struct {
    /// The unique identifier of the Q App associated with the library item.
    app_id: []const u8,

    /// The version of the Q App associated with the library item.
    app_version: i32,

    /// The categories associated with the library item.
    categories: []const Category,

    /// The date and time the library item was created.
    created_at: i64,

    /// The user who created the library item.
    created_by: []const u8,

    /// Whether the current user has rated the library item.
    is_rated_by_user: ?bool,

    /// Indicates whether the library item has been verified.
    is_verified: ?bool,

    /// The unique identifier of the library item.
    library_item_id: []const u8,

    /// The number of ratings the library item has received.
    rating_count: i32,

    /// The status of the library item.
    status: []const u8,

    /// The date and time the library item was last updated.
    updated_at: ?i64,

    /// The user who last updated the library item.
    updated_by: ?[]const u8,

    /// The number of users who have the associated Q App.
    user_count: ?i32,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_version = "appVersion",
        .categories = "categories",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .is_rated_by_user = "isRatedByUser",
        .is_verified = "isVerified",
        .library_item_id = "libraryItemId",
        .rating_count = "ratingCount",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .user_count = "userCount",
    };
};
