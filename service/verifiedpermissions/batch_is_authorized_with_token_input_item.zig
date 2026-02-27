const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const ContextDefinition = @import("context_definition.zig").ContextDefinition;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// An authorization request that you include in a `BatchIsAuthorizedWithToken`
/// API request.
pub const BatchIsAuthorizedWithTokenInputItem = struct {
    /// Specifies the requested action to be authorized. For example,
    /// `PhotoFlash::ReadPhoto`.
    action: ?ActionIdentifier,

    /// Specifies additional context that can be used to make more granular
    /// authorization decisions.
    context: ?ContextDefinition,

    /// Specifies the resource that you want an authorization decision for. For
    /// example, `PhotoFlash::Photo`.
    resource: ?EntityIdentifier,

    pub const json_field_names = .{
        .action = "action",
        .context = "context",
        .resource = "resource",
    };
};
