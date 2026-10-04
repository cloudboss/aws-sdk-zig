const Pillar = @import("pillar.zig").Pillar;

/// Summary of an optimization goal associated with a profile.
pub const GoalSummary = struct {
    /// The timestamp when the goal was created.
    created_at: i64,

    /// The identifier of the user or system that created this goal.
    created_by: []const u8,

    /// A description of the goal.
    description: ?[]const u8 = null,

    /// The unique identifier of the goal.
    id: []const u8,

    /// The timestamp when the goal was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this goal.
    last_modified_by: ?[]const u8 = null,

    /// The Well-Architected Tool Framework pillars associated with this goal.
    pillars: []const Pillar,

    /// The Amazon Resource Name (ARN) of the associated profile.
    profile_arn: []const u8,

    /// The title of the goal.
    title: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .pillars = "pillars",
        .profile_arn = "profileArn",
        .title = "title",
    };
};
