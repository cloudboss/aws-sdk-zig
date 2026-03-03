const Attribute = @import("attribute.zig").Attribute;
const Scope = @import("scope.zig").Scope;

/// Contains information about what was excluded from an assessment run.
pub const Exclusion = struct {
    /// The ARN that specifies the exclusion.
    arn: []const u8,

    /// The system-defined attributes for the exclusion.
    attributes: ?[]const Attribute = null,

    /// The description of the exclusion.
    description: []const u8,

    /// The recommendation for the exclusion.
    recommendation: []const u8,

    /// The AWS resources for which the exclusion pertains.
    scopes: []const Scope,

    /// The name of the exclusion.
    title: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .attributes = "attributes",
        .description = "description",
        .recommendation = "recommendation",
        .scopes = "scopes",
        .title = "title",
    };
};
