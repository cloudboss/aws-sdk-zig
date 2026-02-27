const HubStatus = @import("hub_status.zig").HubStatus;

/// Information about a hub.
pub const HubInfo = struct {
    /// The date and time that the hub was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the hub.
    hub_arn: []const u8,

    /// A description of the hub.
    hub_description: ?[]const u8,

    /// The display name of the hub.
    hub_display_name: ?[]const u8,

    /// The name of the hub.
    hub_name: []const u8,

    /// The searchable keywords for the hub.
    hub_search_keywords: ?[]const []const u8,

    /// The status of the hub.
    hub_status: HubStatus,

    /// The date and time that the hub was last modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .hub_arn = "HubArn",
        .hub_description = "HubDescription",
        .hub_display_name = "HubDisplayName",
        .hub_name = "HubName",
        .hub_search_keywords = "HubSearchKeywords",
        .hub_status = "HubStatus",
        .last_modified_time = "LastModifiedTime",
    };
};
