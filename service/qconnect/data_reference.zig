const ContentReference = @import("content_reference.zig").ContentReference;
const GenerativeReference = @import("generative_reference.zig").GenerativeReference;
const SuggestedMessageReference = @import("suggested_message_reference.zig").SuggestedMessageReference;

/// Reference data.
pub const DataReference = union(enum) {
    content_reference: ?ContentReference,
    /// Reference information about the generative content.
    generative_reference: ?GenerativeReference,
    /// Reference information for suggested messages.
    suggested_message_reference: ?SuggestedMessageReference,

    pub const json_field_names = .{
        .content_reference = "contentReference",
        .generative_reference = "generativeReference",
        .suggested_message_reference = "suggestedMessageReference",
    };
};
