/// The range of part indexes for which to return presigned upload URLs from
/// GetAttachmentUploadLinks.
pub const UploadRange = struct {
    /// The ending part index of the range, exclusive. The range is half-open:
    /// `startIndex` is inclusive and `endIndex` is exclusive. For example,
    /// a range with `startIndex` of 1 and `endIndex` of 4 requests URLs for
    /// parts 1, 2, and 3. The range size (`endIndex` - `startIndex`)
    /// must not exceed 10. If you omit `endIndex`, the service defaults to
    /// `startIndex` + 10, capped by the total number of parts.
    end_index: ?i32 = null,

    /// The starting part index of the range, inclusive. Part indexes start at 1.
    start_index: i32,

    pub const json_field_names = .{
        .end_index = "endIndex",
        .start_index = "startIndex",
    };
};
