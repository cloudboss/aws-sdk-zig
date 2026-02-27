/// Details about the source of an input image in the result from a function in
/// the action group invocation.
pub const ImageInputSource = union(enum) {
    /// The raw image bytes for the image. If you use an Amazon Web Services SDK,
    /// you don't need to encode the image bytes in base64.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
