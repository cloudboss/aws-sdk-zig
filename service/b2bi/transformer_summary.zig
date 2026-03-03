const EdiType = @import("edi_type.zig").EdiType;
const FileFormat = @import("file_format.zig").FileFormat;
const InputConversion = @import("input_conversion.zig").InputConversion;
const Mapping = @import("mapping.zig").Mapping;
const OutputConversion = @import("output_conversion.zig").OutputConversion;
const SampleDocuments = @import("sample_documents.zig").SampleDocuments;
const TransformerStatus = @import("transformer_status.zig").TransformerStatus;

/// Contains the details for a transformer object. A transformer can take an EDI
/// file as input and transform it into a JSON-or XML-formatted document.
/// Alternatively, a transformer can take a JSON-or XML-formatted document as
/// input and transform it into an EDI file.
pub const TransformerSummary = struct {
    /// Returns a timestamp indicating when the transformer was created. For
    /// example, `2023-07-20T19:58:44.624Z`.
    created_at: i64,

    /// Returns the details for the EDI standard that is being used for the
    /// transformer. Currently, only X12 is supported. X12 is a set of standards and
    /// corresponding messages that define specific business documents.
    edi_type: ?EdiType = null,

    /// Returns that the currently supported file formats for EDI transformations
    /// are `JSON` and `XML`.
    file_format: FileFormat = "NOT_USED",

    /// Returns a structure that contains the format options for the transformation.
    input_conversion: ?InputConversion = null,

    /// Returns the structure that contains the mapping template and its language
    /// (either XSLT or JSONATA).
    mapping: ?Mapping = null,

    /// Returns the mapping template for the transformer. This template is used to
    /// map the parsed EDI file using JSONata or XSLT.
    mapping_template: []const u8 = "NOT_USED",

    /// Returns a timestamp representing the date and time for the most recent
    /// change for the transformer object.
    modified_at: ?i64 = null,

    /// Returns the descriptive name for the transformer.
    name: []const u8,

    /// Returns the `OutputConversion` object, which contains the format options for
    /// the outbound transformation.
    output_conversion: ?OutputConversion = null,

    /// Returns a sample EDI document that is used by a transformer as a guide for
    /// processing the EDI data.
    sample_document: ?[]const u8 = null,

    /// Returns a structure that contains the Amazon S3 bucket and an array of the
    /// corresponding keys used to identify the location for your sample documents.
    sample_documents: ?SampleDocuments = null,

    /// Returns the state of the newly created transformer. The transformer can be
    /// either `active` or `inactive`. For the transformer to be used in a
    /// capability, its status must `active`.
    status: TransformerStatus,

    /// Returns the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .edi_type = "ediType",
        .file_format = "fileFormat",
        .input_conversion = "inputConversion",
        .mapping = "mapping",
        .mapping_template = "mappingTemplate",
        .modified_at = "modifiedAt",
        .name = "name",
        .output_conversion = "outputConversion",
        .sample_document = "sampleDocument",
        .sample_documents = "sampleDocuments",
        .status = "status",
        .transformer_id = "transformerId",
    };
};
