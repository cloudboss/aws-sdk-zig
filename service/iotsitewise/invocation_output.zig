const Citation = @import("citation.zig").Citation;

/// This contains the SiteWise Assistant's response and the corresponding
/// citation.
pub const InvocationOutput = struct {
    /// A list of citations, and related information for the SiteWise Assistant's
    /// response.
    citations: ?[]const Citation = null,

    /// The text message of the SiteWise Assistant's response.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .citations = "citations",
        .message = "message",
    };
};
