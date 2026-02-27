const InlineCustomDocumentEnrichmentConfiguration = @import("inline_custom_document_enrichment_configuration.zig").InlineCustomDocumentEnrichmentConfiguration;
const HookConfiguration = @import("hook_configuration.zig").HookConfiguration;

/// Provides the configuration information for altering document metadata and
/// content
/// during the document ingestion process.
///
/// For more information, see [Customizing document metadata
/// during the ingestion
/// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
pub const CustomDocumentEnrichmentConfiguration = struct {
    /// Configuration information to alter document attributes or metadata fields
    /// and content
    /// when ingesting documents into Amazon Kendra.
    inline_configurations: ?[]const InlineCustomDocumentEnrichmentConfiguration,

    /// Configuration information for invoking a Lambda function in Lambda on
    /// the structured documents with their metadata and text extracted. You can use
    /// a Lambda
    /// function to apply advanced logic for creating, modifying, or deleting
    /// document metadata
    /// and content. For more information, see [Advanced data
    /// manipulation](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html#advanced-data-manipulation).
    post_extraction_hook_configuration: ?HookConfiguration,

    /// Configuration information for invoking a Lambda function in Lambda on
    /// the original or raw documents before extracting their metadata and text. You
    /// can use a
    /// Lambda function to apply advanced logic for creating, modifying, or deleting
    /// document
    /// metadata and content. For more information, see [Advanced data
    /// manipulation](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html#advanced-data-manipulation).
    pre_extraction_hook_configuration: ?HookConfiguration,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to run
    /// `PreExtractionHookConfiguration` and
    /// `PostExtractionHookConfiguration` for altering document metadata and
    /// content during the document ingestion process. For more information, see [an
    /// IAM roles for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .inline_configurations = "InlineConfigurations",
        .post_extraction_hook_configuration = "PostExtractionHookConfiguration",
        .pre_extraction_hook_configuration = "PreExtractionHookConfiguration",
        .role_arn = "RoleArn",
    };
};
