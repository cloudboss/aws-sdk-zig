const ApplicationType = @import("application_type.zig").ApplicationType;
const ContextContent = @import("context_content.zig").ContextContent;
const ContextType = @import("context_type.zig").ContextType;
const Criticality = @import("criticality.zig").Criticality;

/// Summary of a context associated with a profile, representing application or
/// environment information used during recommendation generation.
pub const ContextSummary = struct {
    /// The type of application described by this context.
    application_type: ?ApplicationType = null,

    /// The typed content of the context, containing application-specific fields
    /// such as account IDs, Regions, services, and resource types.
    content: ContextContent,

    /// The type of the context.
    context_type: ContextType,

    /// The timestamp when the context was created.
    created_at: i64,

    /// The identifier of the user or system that created this context.
    created_by: []const u8,

    /// The business criticality of the application described by this context.
    criticality: ?Criticality = null,

    /// The unique identifier of the context.
    id: []const u8,

    /// The timestamp when the context was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this context.
    last_modified_by: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the associated profile.
    profile_arn: []const u8,

    /// The title of the context.
    title: []const u8,

    pub const json_field_names = .{
        .application_type = "applicationType",
        .content = "content",
        .context_type = "contextType",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .criticality = "criticality",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .profile_arn = "profileArn",
        .title = "title",
    };
};
