const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;

/// An object that contains an `Engagement`'s subset of fields.
pub const EngagementSummary = struct {
    /// The Amazon Resource Name (ARN) of the created Engagement.
    arn: ?[]const u8,

    /// An array of context types associated with the engagement, such as
    /// "CustomerProject" or "Lead". This provides a quick overview of the types of
    /// contexts included in the engagement.
    context_types: ?[]const EngagementContextType,

    /// The date and time when the Engagement was created.
    created_at: ?i64,

    /// The AWS Account ID of the Engagement creator.
    created_by: ?[]const u8,

    /// The unique identifier for the Engagement.
    id: ?[]const u8,

    /// The number of members in the Engagement.
    member_count: ?i32,

    /// The timestamp indicating when the engagement was last modified, in ISO 8601
    /// format (UTC). Example: "2023-05-01T20:37:46Z".
    modified_at: ?i64,

    /// The AWS account ID of the user who last modified the engagement. This field
    /// helps track who made the most recent changes to the engagement.
    modified_by: ?[]const u8,

    /// The title of the Engagement.
    title: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .context_types = "ContextTypes",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .id = "Id",
        .member_count = "MemberCount",
        .modified_at = "ModifiedAt",
        .modified_by = "ModifiedBy",
        .title = "Title",
    };
};
