const LinkAttributeUpdate = @import("link_attribute_update.zig").LinkAttributeUpdate;
const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Updates a given typed link’s attributes inside a BatchRead operation.
/// Attributes to be updated must not contribute to the typed link’s identity,
/// as defined by its `IdentityAttributeOrder`. For more information, see
/// UpdateLinkAttributes and BatchReadRequest$Operations.
pub const BatchUpdateLinkAttributes = struct {
    /// The attributes update structure.
    attribute_updates: []const LinkAttributeUpdate,

    /// Allows a typed link specifier to be accepted as input.
    typed_link_specifier: TypedLinkSpecifier,

    pub const json_field_names = .{
        .attribute_updates = "AttributeUpdates",
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};
