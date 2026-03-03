const aws = @import("aws");

const QuickResponseStatus = @import("quick_response_status.zig").QuickResponseStatus;

/// The summary information about the quick response.
pub const QuickResponseSummary = struct {
    /// The Amazon Connect contact channels this quick response applies to. The
    /// supported contact channel types include `Chat`.
    channels: ?[]const []const u8 = null,

    /// The media type of the quick response content.
    ///
    /// * Use `application/x.quickresponse;format=plain` for quick response written
    ///   in plain text.
    /// * Use `application/x.quickresponse;format=markdown` for quick response
    ///   written in richtext.
    content_type: []const u8,

    /// The timestamp when the quick response was created.
    created_time: i64,

    /// The description of the quick response.
    description: ?[]const u8 = null,

    /// Whether the quick response is active.
    is_active: ?bool = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The Amazon Resource Name (ARN) of the user who last updated the quick
    /// response data.
    last_modified_by: ?[]const u8 = null,

    /// The timestamp when the quick response summary was last modified.
    last_modified_time: i64,

    /// The name of the quick response.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the quick response.
    quick_response_arn: []const u8,

    /// The identifier of the quick response.
    quick_response_id: []const u8,

    /// The resource status of the quick response.
    status: QuickResponseStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channels = "channels",
        .content_type = "contentType",
        .created_time = "createdTime",
        .description = "description",
        .is_active = "isActive",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .quick_response_arn = "quickResponseArn",
        .quick_response_id = "quickResponseId",
        .status = "status",
        .tags = "tags",
    };
};
