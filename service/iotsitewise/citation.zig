const Content = @import("content.zig").Content;
const Reference = @import("reference.zig").Reference;

/// Contains text content to which the SiteWise Assistant refers to, and
/// generate the final response.
/// It also contains information about the source.
pub const Citation = struct {
    /// Contains the cited text from the data source.
    content: ?Content,

    /// Contains information about the data source.
    reference: ?Reference,

    pub const json_field_names = .{
        .content = "content",
        .reference = "reference",
    };
};
