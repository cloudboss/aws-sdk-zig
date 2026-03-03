const SubscribedListingItem = @import("subscribed_listing_item.zig").SubscribedListingItem;

/// The details of the published asset for which the subscription grant is
/// created.
pub const SubscribedListing = struct {
    /// The description of the published asset for which the subscription grant is
    /// created.
    description: []const u8,

    /// The identifier of the published asset for which the subscription grant is
    /// created.
    id: []const u8,

    /// The published asset for which the subscription grant is created.
    item: SubscribedListingItem,

    /// The name of the published asset for which the subscription grant is created.
    name: []const u8,

    /// The identifier of the project of the published asset for which the
    /// subscription grant is created.
    owner_project_id: []const u8,

    /// The name of the project that owns the published asset for which the
    /// subscription grant is created.
    owner_project_name: ?[]const u8 = null,

    /// The revision of the published asset for which the subscription grant is
    /// created.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .item = "item",
        .name = "name",
        .owner_project_id = "ownerProjectId",
        .owner_project_name = "ownerProjectName",
        .revision = "revision",
    };
};
