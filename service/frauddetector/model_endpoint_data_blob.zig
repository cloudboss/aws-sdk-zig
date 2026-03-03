/// A pre-formed Amazon SageMaker model input you can include if your detector
/// version includes an imported Amazon SageMaker model endpoint with
/// pass-through input configuration.
pub const ModelEndpointDataBlob = struct {
    /// The byte buffer of the Amazon SageMaker model endpoint input data blob.
    byte_buffer: ?[]const u8 = null,

    /// The content type of the Amazon SageMaker model endpoint input data blob.
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .byte_buffer = "byteBuffer",
        .content_type = "contentType",
    };
};
