const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const CardOutputSource = @import("card_output_source.zig").CardOutputSource;
const CardType = @import("card_type.zig").CardType;

/// The input shape for defining a query card in an Amazon Q App.
pub const QQueryCardInput = struct {
    /// Turns on filtering of responses based on document attributes or metadata
    /// fields.
    attribute_filter: ?AttributeFilter = null,

    /// The unique identifier of the query card.
    id: []const u8,

    /// The source or type of output to generate for the query card.
    output_source: CardOutputSource = .approved_sources,

    /// The prompt or instructions displayed for the query card.
    prompt: []const u8,

    /// The title or label of the query card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType = .q_query,

    pub const json_field_names = .{
        .attribute_filter = "attributeFilter",
        .id = "id",
        .output_source = "outputSource",
        .prompt = "prompt",
        .title = "title",
        .@"type" = "type",
    };
};
