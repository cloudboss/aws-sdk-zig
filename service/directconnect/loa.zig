const LoaContentType = @import("loa_content_type.zig").LoaContentType;

/// Information about a Letter of Authorization - Connecting Facility Assignment
/// (LOA-CFA) for a connection.
pub const Loa = struct {
    /// The binary contents of the LOA-CFA document.
    loa_content: ?[]const u8 = null,

    /// The standard media type for the LOA-CFA document. The only supported value
    /// is application/pdf.
    loa_content_type: ?LoaContentType = null,

    pub const json_field_names = .{
        .loa_content = "loaContent",
        .loa_content_type = "loaContentType",
    };
};
