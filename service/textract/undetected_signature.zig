/// A structure containing information about an undetected signature on a page
/// where it was expected but not found.
pub const UndetectedSignature = struct {
    /// The page where a signature was expected but not found.
    page: ?i32,

    pub const json_field_names = .{
        .page = "Page",
    };
};
