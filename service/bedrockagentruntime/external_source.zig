const ByteContentDoc = @import("byte_content_doc.zig").ByteContentDoc;
const S3ObjectDoc = @import("s3_object_doc.zig").S3ObjectDoc;
const ExternalSourceType = @import("external_source_type.zig").ExternalSourceType;

/// The unique external source of the content contained in the wrapper object.
pub const ExternalSource = struct {
    /// The identifier, contentType, and data of the external source wrapper object.
    byte_content: ?ByteContentDoc = null,

    /// The S3 location of the external source wrapper object.
    s_3_location: ?S3ObjectDoc = null,

    /// The source type of the external source wrapper object.
    source_type: ExternalSourceType,

    pub const json_field_names = .{
        .byte_content = "byteContent",
        .s_3_location = "s3Location",
        .source_type = "sourceType",
    };
};
