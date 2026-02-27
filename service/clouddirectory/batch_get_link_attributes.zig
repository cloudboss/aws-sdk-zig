const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Retrieves attributes that are associated with a typed link inside a
/// BatchRead operation. For more information, see GetLinkAttributes and
/// BatchReadRequest$Operations.
pub const BatchGetLinkAttributes = struct {
    /// A list of attribute names whose values will be retrieved.
    attribute_names: []const []const u8,

    /// Allows a typed link specifier to be accepted as input.
    typed_link_specifier: TypedLinkSpecifier,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};
