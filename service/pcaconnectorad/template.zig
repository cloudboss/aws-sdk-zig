const TemplateDefinition = @import("template_definition.zig").TemplateDefinition;
const TemplateRevision = @import("template_revision.zig").TemplateRevision;
const TemplateStatus = @import("template_status.zig").TemplateStatus;

/// An Active Directory compatible certificate template. Connectors issue
/// certificates against these
/// templates based on the requestor's Active Directory group membership.
pub const Template = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateTemplate](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateTemplate.html).
    arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateConnector](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector.html).
    connector_arn: ?[]const u8,

    /// The date and time that the template was created.
    created_at: ?i64,

    /// Template configuration to define the information included in certificates.
    /// Define
    /// certificate validity and renewal periods, certificate request handling and
    /// enrollment
    /// options, key usage extensions, application policies, and cryptography
    /// settings.
    definition: ?TemplateDefinition,

    /// Name of the templates. Template names must be unique.
    name: ?[]const u8,

    /// Object identifier of a template.
    object_identifier: ?[]const u8,

    /// The template schema version. Template schema versions can be v2, v3, or v4.
    /// The template
    /// configuration options change based on the template schema version.
    policy_schema: ?i32,

    /// The version of the template. Template updates will increment the minor
    /// revision.
    /// Re-enrolling all certificate holders will increment the major revision.
    revision: ?TemplateRevision,

    /// Status of the template. Status can be creating, active, deleting, or failed.
    status: ?TemplateStatus,

    /// The date and time that the template was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .connector_arn = "ConnectorArn",
        .created_at = "CreatedAt",
        .definition = "Definition",
        .name = "Name",
        .object_identifier = "ObjectIdentifier",
        .policy_schema = "PolicySchema",
        .revision = "Revision",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
