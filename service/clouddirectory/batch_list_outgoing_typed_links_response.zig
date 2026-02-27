const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Represents the output of a ListOutgoingTypedLinks response operation.
pub const BatchListOutgoingTypedLinksResponse = struct {
    /// The pagination token.
    next_token: ?[]const u8,

    /// Returns a typed link specifier as output.
    typed_link_specifiers: ?[]const TypedLinkSpecifier,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .typed_link_specifiers = "TypedLinkSpecifiers",
    };
};
