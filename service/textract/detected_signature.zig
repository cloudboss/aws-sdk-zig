/// A structure that holds information regarding a detected signature on a page.
pub const DetectedSignature = struct {
    /// The page a detected signature was found on.
    page: ?i32 = null,

    pub const json_field_names = .{
        .page = "Page",
    };
};
