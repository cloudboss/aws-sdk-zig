const ItemIdentifier = @import("item_identifier.zig").ItemIdentifier;

/// Resources that responders use to triage and mitigate the incident.
pub const RelatedItem = struct {
    /// A unique ID for a `RelatedItem`.
    ///
    /// Don't specify this parameter when you add a `RelatedItem` by using the
    /// UpdateRelatedItems API action.
    generated_id: ?[]const u8 = null,

    /// Details about the related item.
    identifier: ItemIdentifier,

    /// The title of the related item.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .generated_id = "generatedId",
        .identifier = "identifier",
        .title = "title",
    };
};
