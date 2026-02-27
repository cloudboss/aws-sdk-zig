const MetadataAttribute = @import("metadata_attribute.zig").MetadataAttribute;
const CustomS3Location = @import("custom_s3_location.zig").CustomS3Location;
const MetadataSourceType = @import("metadata_source_type.zig").MetadataSourceType;

/// Contains information about the metadata associate with the content to ingest
/// into a knowledge base. Choose a `type` and include the field that
/// corresponds to it.
pub const DocumentMetadata = struct {
    /// An array of objects, each of which defines a metadata attribute to associate
    /// with the content to ingest. You define the attributes inline.
    inline_attributes: ?[]const MetadataAttribute,

    /// The Amazon S3 location of the file containing metadata to associate with the
    /// content to ingest.
    s_3_location: ?CustomS3Location,

    /// The type of the source source from which to add metadata.
    type: MetadataSourceType,

    pub const json_field_names = .{
        .inline_attributes = "inlineAttributes",
        .s_3_location = "s3Location",
        .type = "type",
    };
};
