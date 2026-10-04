const HubContentDependency = @import("hub_content_dependency.zig").HubContentDependency;
const HubContentStatus = @import("hub_content_status.zig").HubContentStatus;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;
const Tag = @import("tag.zig").Tag;

/// Contains information about a hub content resource, including its name,
/// version, type, associated documents, dependencies, and status, as returned
/// by a search result.
pub const HubContent = struct {
    /// The date and time that hub content was created.
    creation_time: i64,

    /// The document schema version for the hub content.
    document_schema_version: []const u8,

    /// The failure reason if importing hub content failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hub that contains the content.
    hub_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the hub content.
    hub_content_arn: []const u8,

    /// The location of any dependencies that the hub content has, such as scripts,
    /// model artifacts, datasets, or notebooks.
    hub_content_dependencies: ?[]const HubContentDependency = null,

    /// A description of the hub content.
    hub_content_description: ?[]const u8 = null,

    /// The display name of the hub content.
    hub_content_display_name: ?[]const u8 = null,

    /// The hub content document that describes information about the hub content
    /// such as type, associated containers, scripts, and more.
    hub_content_document: ?[]const u8 = null,

    /// A string that provides a description of the hub content. This string can
    /// include links, tables, and standard markdown formatting.
    hub_content_markdown: ?[]const u8 = null,

    /// The name of the hub content.
    hub_content_name: []const u8,

    /// The searchable keywords for the hub content.
    hub_content_search_keywords: ?[]const []const u8 = null,

    /// The status of the hub content.
    hub_content_status: HubContentStatus,

    /// The type of hub content.
    hub_content_type: HubContentType,

    /// The version of the hub content.
    hub_content_version: []const u8,

    /// The name of the hub that contains the content.
    hub_name: []const u8,

    /// The last modified time of the hub content.
    last_modified_time: ?i64 = null,

    /// The minimum version of the hub content.
    reference_min_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the public hub content.
    sage_maker_public_hub_content_arn: ?[]const u8 = null,

    /// The support status of the hub content.
    support_status: ?HubContentSupportStatus = null,

    /// Any tags associated with the hub content.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .document_schema_version = "DocumentSchemaVersion",
        .failure_reason = "FailureReason",
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
        .hub_content_dependencies = "HubContentDependencies",
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_document = "HubContentDocument",
        .hub_content_markdown = "HubContentMarkdown",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_status = "HubContentStatus",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .last_modified_time = "LastModifiedTime",
        .reference_min_version = "ReferenceMinVersion",
        .sage_maker_public_hub_content_arn = "SageMakerPublicHubContentArn",
        .support_status = "SupportStatus",
        .tags = "Tags",
    };
};
