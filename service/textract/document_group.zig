const DetectedSignature = @import("detected_signature.zig").DetectedSignature;
const SplitDocument = @import("split_document.zig").SplitDocument;
const UndetectedSignature = @import("undetected_signature.zig").UndetectedSignature;

/// Summary information about documents grouped by the same document type.
pub const DocumentGroup = struct {
    /// A list of the detected signatures found in a document group.
    detected_signatures: ?[]const DetectedSignature,

    /// An array that contains information about the pages of a document, defined by
    /// logical boundary.
    split_documents: ?[]const SplitDocument,

    /// The type of document that Amazon Textract has detected. See [Analyze Lending
    /// Response
    /// Objects](https://docs.aws.amazon.com/textract/latest/dg/lending-response-objects.html) for a list of all types returned by Textract.
    @"type": ?[]const u8,

    /// A list of any expected signatures not found in a document group.
    undetected_signatures: ?[]const UndetectedSignature,

    pub const json_field_names = .{
        .detected_signatures = "DetectedSignatures",
        .split_documents = "SplitDocuments",
        .@"type" = "Type",
        .undetected_signatures = "UndetectedSignatures",
    };
};
