const AttachmentInformation = @import("attachment_information.zig").AttachmentInformation;
const DocumentFormat = @import("document_format.zig").DocumentFormat;
const DocumentType = @import("document_type.zig").DocumentType;
const DocumentHashType = @import("document_hash_type.zig").DocumentHashType;
const DocumentParameter = @import("document_parameter.zig").DocumentParameter;
const PlatformType = @import("platform_type.zig").PlatformType;
const DocumentRequires = @import("document_requires.zig").DocumentRequires;
const ReviewInformation = @import("review_information.zig").ReviewInformation;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const DocumentStatus = @import("document_status.zig").DocumentStatus;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon Web Services Systems Manager document (SSM document).
pub const DocumentDescription = struct {
    /// The version of the document currently approved for use in the organization.
    approved_version: ?[]const u8,

    /// Details about the document attachments, including names, locations, sizes,
    /// and so on.
    attachments_information: ?[]const AttachmentInformation,

    /// The user in your organization who created the document.
    author: ?[]const u8,

    /// The classification of a document to help you identify and categorize its
    /// use.
    category: ?[]const []const u8,

    /// The value that identifies a document's category.
    category_enum: ?[]const []const u8,

    /// The date when the document was created.
    created_date: ?i64,

    /// The default version.
    default_version: ?[]const u8,

    /// A description of the document.
    description: ?[]const u8,

    /// The friendly name of the SSM document. This value can differ for each
    /// version of the
    /// document. If you want to update this value, see UpdateDocument.
    display_name: ?[]const u8,

    /// The document format, either JSON or YAML.
    document_format: ?DocumentFormat,

    /// The type of document.
    document_type: ?DocumentType,

    /// The document version.
    document_version: ?[]const u8,

    /// The Sha256 or Sha1 hash created by the system when the document was created.
    ///
    /// Sha1 hashes have been deprecated.
    hash: ?[]const u8,

    /// The hash type of the document. Valid values include `Sha256` or
    /// `Sha1`.
    ///
    /// Sha1 hashes have been deprecated.
    hash_type: ?DocumentHashType,

    /// The latest version of the document.
    latest_version: ?[]const u8,

    /// The name of the SSM document.
    name: ?[]const u8,

    /// The Amazon Web Services user that created the document.
    owner: ?[]const u8,

    /// A description of the parameters for a document.
    parameters: ?[]const DocumentParameter,

    /// The version of the document that is currently under review.
    pending_review_version: ?[]const u8,

    /// The list of operating system (OS) platforms compatible with this SSM
    /// document.
    platform_types: ?[]const PlatformType,

    /// A list of SSM documents required by a document. For example, an
    /// `ApplicationConfiguration` document requires an
    /// `ApplicationConfigurationSchema` document.
    requires: ?[]const DocumentRequires,

    /// Details about the review of a document.
    review_information: ?[]const ReviewInformation,

    /// The current status of the review.
    review_status: ?ReviewStatus,

    /// The schema version.
    schema_version: ?[]const u8,

    /// The SHA1 hash of the document, which you can use for verification.
    sha_1: ?[]const u8,

    /// The status of the SSM document.
    status: ?DocumentStatus,

    /// A message returned by Amazon Web Services Systems Manager that explains the
    /// `Status` value. For example, a
    /// `Failed` status might be explained by the `StatusInformation` message,
    /// "The specified S3 bucket doesn't exist. Verify that the URL of the S3 bucket
    /// is correct."
    status_information: ?[]const u8,

    /// The tags, or metadata, that have been applied to the document.
    tags: ?[]const Tag,

    /// The target type which defines the kinds of resources the document can run
    /// on. For example,
    /// `/AWS::EC2::Instance`. For a list of valid resource types, see [Amazon Web
    /// Services resource and
    /// property types
    /// reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) in the *CloudFormation User Guide*.
    target_type: ?[]const u8,

    /// The version of the artifact associated with the document.
    version_name: ?[]const u8,

    pub const json_field_names = .{
        .approved_version = "ApprovedVersion",
        .attachments_information = "AttachmentsInformation",
        .author = "Author",
        .category = "Category",
        .category_enum = "CategoryEnum",
        .created_date = "CreatedDate",
        .default_version = "DefaultVersion",
        .description = "Description",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_type = "DocumentType",
        .document_version = "DocumentVersion",
        .hash = "Hash",
        .hash_type = "HashType",
        .latest_version = "LatestVersion",
        .name = "Name",
        .owner = "Owner",
        .parameters = "Parameters",
        .pending_review_version = "PendingReviewVersion",
        .platform_types = "PlatformTypes",
        .requires = "Requires",
        .review_information = "ReviewInformation",
        .review_status = "ReviewStatus",
        .schema_version = "SchemaVersion",
        .sha_1 = "Sha1",
        .status = "Status",
        .status_information = "StatusInformation",
        .tags = "Tags",
        .target_type = "TargetType",
        .version_name = "VersionName",
    };
};
