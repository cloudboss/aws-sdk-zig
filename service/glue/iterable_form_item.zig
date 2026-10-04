const aws = @import("aws");

const AssetFormEntry = @import("asset_form_entry.zig").AssetFormEntry;

/// A full iterable form item with its forms.
pub const IterableFormItem = struct {
    /// Additional attachments on the item for more context, keyed by attachment
    /// name.
    attachments: ?[]const aws.map.MapEntry(AssetFormEntry) = null,

    /// The forms on the item, keyed by form name.
    forms: ?[]const aws.map.MapEntry(AssetFormEntry) = null,

    /// The identifiers of the glossary terms associated with the item.
    glossary_terms: ?[]const []const u8 = null,

    /// The unique identifier of the item.
    item_id: ?[]const u8 = null,

    /// The name of the item.
    item_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .forms = "Forms",
        .glossary_terms = "GlossaryTerms",
        .item_id = "ItemId",
        .item_name = "ItemName",
    };
};
