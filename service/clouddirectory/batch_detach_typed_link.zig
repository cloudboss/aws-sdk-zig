const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Detaches a typed link from a specified source and target object inside a
/// BatchRead operation. For more information, see DetachTypedLink and
/// BatchReadRequest$Operations.
pub const BatchDetachTypedLink = struct {
    /// Used to accept a typed link specifier as input.
    typed_link_specifier: TypedLinkSpecifier,

    pub const json_field_names = .{
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};
