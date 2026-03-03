const DocumentFormat = @import("document_format.zig").DocumentFormat;
const DocumentType = @import("document_type.zig").DocumentType;
const PlatformType = @import("platform_type.zig").PlatformType;
const DocumentRequires = @import("document_requires.zig").DocumentRequires;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Tag = @import("tag.zig").Tag;

/// Describes the name of a SSM document.
pub const DocumentIdentifier = struct {
    /// The user in your organization who created the document.
    author: ?[]const u8 = null,

    /// The date the SSM document was created.
    created_date: ?i64 = null,

    /// An optional field where you can specify a friendly name for the SSM
    /// document. This value can
    /// differ for each version of the document. If you want to update this value,
    /// see UpdateDocument.
    display_name: ?[]const u8 = null,

    /// The document format, either JSON or YAML.
    document_format: ?DocumentFormat = null,

    /// The document type.
    document_type: ?DocumentType = null,

    /// The document version.
    document_version: ?[]const u8 = null,

    /// The name of the SSM document.
    name: ?[]const u8 = null,

    /// The Amazon Web Services user that created the document.
    owner: ?[]const u8 = null,

    /// The operating system platform.
    platform_types: ?[]const PlatformType = null,

    /// A list of SSM documents required by a document. For example, an
    /// `ApplicationConfiguration` document requires an
    /// `ApplicationConfigurationSchema` document.
    requires: ?[]const DocumentRequires = null,

    /// The current status of a document review.
    review_status: ?ReviewStatus = null,

    /// The schema version.
    schema_version: ?[]const u8 = null,

    /// The tags, or metadata, that have been applied to the document.
    tags: ?[]const Tag = null,

    /// The target type which defines the kinds of resources the document can run
    /// on. For example,
    /// `/AWS::EC2::Instance`. For a list of valid resource types, see [Amazon Web
    /// Services resource and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    target_type: ?[]const u8 = null,

    /// An optional field specifying the version of the artifact associated with the
    /// document. For
    /// example, 12.6. This value is unique across all versions of a document, and
    /// can't be
    /// changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .author = "Author",
        .created_date = "CreatedDate",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_type = "DocumentType",
        .document_version = "DocumentVersion",
        .name = "Name",
        .owner = "Owner",
        .platform_types = "PlatformTypes",
        .requires = "Requires",
        .review_status = "ReviewStatus",
        .schema_version = "SchemaVersion",
        .tags = "Tags",
        .target_type = "TargetType",
        .version_name = "VersionName",
    };
};
