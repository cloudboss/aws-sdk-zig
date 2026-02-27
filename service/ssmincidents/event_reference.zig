/// An item referenced in a `TimelineEvent` that is involved in or somehow
/// associated with an incident. You can specify an Amazon Resource Name (ARN)
/// for an Amazon Web Services resource or a `RelatedItem` ID.
pub const EventReference = union(enum) {
    /// The ID of a `RelatedItem` referenced in a `TimelineEvent`.
    related_item_id: ?[]const u8,
    /// The Amazon Resource Name (ARN) of an Amazon Web Services resource referenced
    /// in a
    /// `TimelineEvent`.
    resource: ?[]const u8,

    pub const json_field_names = .{
        .related_item_id = "relatedItemId",
        .resource = "resource",
    };
};
