const CustomDocumentIdentifier = @import("custom_document_identifier.zig").CustomDocumentIdentifier;
const InlineContent = @import("inline_content.zig").InlineContent;
const CustomS3Location = @import("custom_s3_location.zig").CustomS3Location;
const CustomSourceType = @import("custom_source_type.zig").CustomSourceType;

/// Contains information about the content to ingest into a knowledge base
/// connected to a custom data source. Choose a `sourceType` and include the
/// field that corresponds to it.
pub const CustomContent = struct {
    /// A unique identifier for the document.
    custom_document_identifier: CustomDocumentIdentifier,

    /// Contains information about content defined inline to ingest into a knowledge
    /// base.
    inline_content: ?InlineContent,

    /// Contains information about the Amazon S3 location of the file from which to
    /// ingest data.
    s_3_location: ?CustomS3Location,

    /// The source of the data to ingest.
    source_type: CustomSourceType,

    pub const json_field_names = .{
        .custom_document_identifier = "customDocumentIdentifier",
        .inline_content = "inlineContent",
        .s_3_location = "s3Location",
        .source_type = "sourceType",
    };
};
