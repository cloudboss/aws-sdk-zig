const HubContentStatus = @import("hub_content_status.zig").HubContentStatus;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;

/// Information about hub content.
pub const HubContentInfo = struct {
    /// The date and time that the hub content was created.
    creation_time: i64,

    /// The version of the hub content document schema.
    document_schema_version: []const u8,

    /// The Amazon Resource Name (ARN) of the hub content.
    hub_content_arn: []const u8,

    /// A description of the hub content.
    hub_content_description: ?[]const u8,

    /// The display name of the hub content.
    hub_content_display_name: ?[]const u8,

    /// The name of the hub content.
    hub_content_name: []const u8,

    /// The searchable keywords for the hub content.
    hub_content_search_keywords: ?[]const []const u8,

    /// The status of the hub content.
    hub_content_status: HubContentStatus,

    /// The type of hub content.
    hub_content_type: HubContentType,

    /// The version of the hub content.
    hub_content_version: []const u8,

    /// The date and time when the hub content was originally created, before any
    /// updates or revisions.
    original_creation_time: ?i64,

    /// The ARN of the public hub content.
    sage_maker_public_hub_content_arn: ?[]const u8,

    /// The support status of the hub content.
    support_status: ?HubContentSupportStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .document_schema_version = "DocumentSchemaVersion",
        .hub_content_arn = "HubContentArn",
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_status = "HubContentStatus",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .original_creation_time = "OriginalCreationTime",
        .sage_maker_public_hub_content_arn = "SageMakerPublicHubContentArn",
        .support_status = "SupportStatus",
    };
};
