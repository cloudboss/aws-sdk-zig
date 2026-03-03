const ConformancePackInputParameter = @import("conformance_pack_input_parameter.zig").ConformancePackInputParameter;
const TemplateSSMDocumentDetails = @import("template_ssm_document_details.zig").TemplateSSMDocumentDetails;

/// Returns details of a conformance pack. A conformance pack is a collection of
/// Config rules and remediation actions that can be easily deployed in an
/// account and a region.
pub const ConformancePackDetail = struct {
    /// Amazon Resource Name (ARN) of the conformance pack.
    conformance_pack_arn: []const u8,

    /// ID of the conformance pack.
    conformance_pack_id: []const u8,

    /// A list of `ConformancePackInputParameter` objects.
    conformance_pack_input_parameters: ?[]const ConformancePackInputParameter = null,

    /// Name of the conformance pack.
    conformance_pack_name: []const u8,

    /// The Amazon Web Services service that created the conformance pack.
    created_by: ?[]const u8 = null,

    /// The name of the Amazon S3 bucket where Config stores conformance pack
    /// templates.
    ///
    /// This field is optional.
    delivery_s3_bucket: ?[]const u8 = null,

    /// The prefix for the Amazon S3 bucket.
    ///
    /// This field is optional.
    delivery_s3_key_prefix: ?[]const u8 = null,

    /// The last time a conformation pack update was requested.
    last_update_requested_time: ?i64 = null,

    /// An object that contains the name or Amazon Resource Name (ARN) of the Amazon
    /// Web Services Systems Manager document (SSM document) and the version of the
    /// SSM document that is used to create a conformance pack.
    template_ssm_document_details: ?TemplateSSMDocumentDetails = null,

    pub const json_field_names = .{
        .conformance_pack_arn = "ConformancePackArn",
        .conformance_pack_id = "ConformancePackId",
        .conformance_pack_input_parameters = "ConformancePackInputParameters",
        .conformance_pack_name = "ConformancePackName",
        .created_by = "CreatedBy",
        .delivery_s3_bucket = "DeliveryS3Bucket",
        .delivery_s3_key_prefix = "DeliveryS3KeyPrefix",
        .last_update_requested_time = "LastUpdateRequestedTime",
        .template_ssm_document_details = "TemplateSSMDocumentDetails",
    };
};
