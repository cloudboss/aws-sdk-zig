/// Details of what related item data is published through the case event
/// stream.
pub const RelatedItemEventIncludedData = struct {
    /// Details of what related item data is published through the case event
    /// stream.
    include_content: bool,

    pub const json_field_names = .{
        .include_content = "includeContent",
    };
};
