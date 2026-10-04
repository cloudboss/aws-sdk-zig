/// The Amazon Simple Storage Service destination for a notebook export in
/// Amazon SageMaker Unified Studio.
pub const S3Destination = struct {
    /// The Amazon Simple Storage Service URI of the exported notebook.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
