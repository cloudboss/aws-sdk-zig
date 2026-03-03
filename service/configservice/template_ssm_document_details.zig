/// This API allows you to create a conformance pack template with an Amazon Web
/// Services Systems Manager document (SSM document).
/// To deploy a conformance pack using an SSM document, first create an SSM
/// document with conformance pack content, and then provide the `DocumentName`
/// in the [PutConformancePack
/// API](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConformancePack.html). You can also provide the `DocumentVersion`.
///
/// The `TemplateSSMDocumentDetails` object contains the name of the SSM
/// document and the version of the SSM document.
pub const TemplateSSMDocumentDetails = struct {
    /// The name or Amazon Resource Name (ARN) of the SSM document to use to create
    /// a conformance pack.
    /// If you use the document name, Config checks only your account and Amazon Web
    /// Services Region for the SSM document.
    document_name: []const u8,

    /// The version of the SSM document to use to create a conformance pack. By
    /// default, Config uses the latest version.
    ///
    /// This field is optional.
    document_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
    };
};
