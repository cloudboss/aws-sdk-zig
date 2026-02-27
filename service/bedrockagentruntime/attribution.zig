const Citation = @import("citation.zig").Citation;

/// Contains citations for a part of an agent response.
pub const Attribution = struct {
    /// A list of citations and related information for a part of an agent response.
    citations: ?[]const Citation,

    pub const json_field_names = .{
        .citations = "citations",
    };
};
