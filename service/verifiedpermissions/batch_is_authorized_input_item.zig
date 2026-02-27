const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const ContextDefinition = @import("context_definition.zig").ContextDefinition;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// An authorization request that you include in a `BatchIsAuthorized` API
/// request.
pub const BatchIsAuthorizedInputItem = struct {
    /// Specifies the requested action to be authorized. For example,
    /// `PhotoFlash::ReadPhoto`.
    action: ?ActionIdentifier,

    /// Specifies additional context that can be used to make more granular
    /// authorization decisions.
    context: ?ContextDefinition,

    /// Specifies the principal for which the authorization decision is to be made.
    principal: ?EntityIdentifier,

    /// Specifies the resource that you want an authorization decision for. For
    /// example, `PhotoFlash::Photo`.
    resource: ?EntityIdentifier,

    pub const json_field_names = .{
        .action = "action",
        .context = "context",
        .principal = "principal",
        .resource = "resource",
    };
};
