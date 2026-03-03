const EngagementContextPayload = @import("engagement_context_payload.zig").EngagementContextPayload;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;

/// Provides detailed context information for an Engagement. This structure
/// allows for specifying the type of context and its associated payload.
pub const EngagementContextDetails = struct {
    /// The unique identifier of the engagement context. This ID is used to
    /// reference and manage the specific context within the engagement.
    id: ?[]const u8 = null,

    /// Contains the specific details of the Engagement context. The structure of
    /// this payload varies depending on the Type field.
    payload: ?EngagementContextPayload = null,

    /// Specifies the type of Engagement context. Valid values are "CustomerProject"
    /// or "Document", indicating whether the context relates to a customer project
    /// or a document respectively.
    @"type": EngagementContextType,

    pub const json_field_names = .{
        .id = "Id",
        .payload = "Payload",
        .@"type" = "Type",
    };
};
