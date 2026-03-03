const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Represents the output of a AttachTypedLink response operation.
pub const BatchAttachTypedLinkResponse = struct {
    /// Returns a typed link specifier as output.
    typed_link_specifier: ?TypedLinkSpecifier = null,

    pub const json_field_names = .{
        .typed_link_specifier = "TypedLinkSpecifier",
    };
};
