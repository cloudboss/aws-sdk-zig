const AppVisibility = @import("app_visibility.zig").AppVisibility;
const EntitlementAttribute = @import("entitlement_attribute.zig").EntitlementAttribute;

/// Specifies an entitlement. Entitlements control access to specific
/// applications within
/// a stack, based on user attributes. Entitlements apply to SAML 2.0 federated
/// user
/// identities. WorkSpaces Applications user pool and streaming URL users are
/// entitled to all
/// applications in a stack. Entitlements don't apply to the desktop stream view
/// application, or to applications managed by a dynamic app provider using the
/// Dynamic
/// Application Framework.
pub const Entitlement = struct {
    /// Specifies whether all or selected apps are entitled.
    app_visibility: AppVisibility,

    /// The attributes of the entitlement.
    attributes: []const EntitlementAttribute,

    /// The time when the entitlement was created.
    created_time: ?i64,

    /// The description of the entitlement.
    description: ?[]const u8,

    /// The time when the entitlement was last modified.
    last_modified_time: ?i64,

    /// The name of the entitlement.
    name: []const u8,

    /// The name of the stack with which the entitlement is associated.
    stack_name: []const u8,

    pub const json_field_names = .{
        .app_visibility = "AppVisibility",
        .attributes = "Attributes",
        .created_time = "CreatedTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .stack_name = "StackName",
    };
};
