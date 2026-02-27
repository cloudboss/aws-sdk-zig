const aws = @import("aws");

const QuickResponseContents = @import("quick_response_contents.zig").QuickResponseContents;
const GroupingConfiguration = @import("grouping_configuration.zig").GroupingConfiguration;
const QuickResponseStatus = @import("quick_response_status.zig").QuickResponseStatus;

/// The result of quick response search.
pub const QuickResponseSearchResultData = struct {
    /// The user defined contact attributes that are resolved when the search result
    /// is returned.
    attributes_interpolated: ?[]const []const u8,

    /// The user defined contact attributes that are not resolved when the search
    /// result is returned.
    attributes_not_interpolated: ?[]const []const u8,

    /// The Amazon Connect contact channels this quick response applies to. The
    /// supported contact channel types include `Chat`.
    channels: ?[]const []const u8,

    /// The contents of the quick response.
    contents: QuickResponseContents,

    /// The media type of the quick response content.
    ///
    /// * Use `application/x.quickresponse;format=plain` for quick response written
    ///   in plain text.
    ///
    /// * Use `application/x.quickresponse;format=markdown` for quick response
    ///   written in richtext.
    content_type: []const u8,

    /// The timestamp when the quick response was created.
    created_time: i64,

    /// The description of the quick response.
    description: ?[]const u8,

    /// The configuration information of the user groups that the quick response is
    /// accessible to.
    grouping_configuration: ?GroupingConfiguration,

    /// Whether the quick response is active.
    is_active: bool,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it. Can be either the ID
    /// or the ARN. URLs cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The language code value for the language in which the quick response is
    /// written.
    language: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who last updated the quick
    /// response search result data.
    last_modified_by: ?[]const u8,

    /// The timestamp when the quick response search result data was last modified.
    last_modified_time: i64,

    /// The name of the quick response.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the quick response.
    quick_response_arn: []const u8,

    /// The identifier of the quick response.
    quick_response_id: []const u8,

    /// The shortcut key of the quick response. The value should be unique across
    /// the
    /// knowledge base.
    shortcut_key: ?[]const u8,

    /// The resource status of the quick response.
    status: QuickResponseStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .attributes_interpolated = "attributesInterpolated",
        .attributes_not_interpolated = "attributesNotInterpolated",
        .channels = "channels",
        .contents = "contents",
        .content_type = "contentType",
        .created_time = "createdTime",
        .description = "description",
        .grouping_configuration = "groupingConfiguration",
        .is_active = "isActive",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .language = "language",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .quick_response_arn = "quickResponseArn",
        .quick_response_id = "quickResponseId",
        .shortcut_key = "shortcutKey",
        .status = "status",
        .tags = "tags",
    };
};
