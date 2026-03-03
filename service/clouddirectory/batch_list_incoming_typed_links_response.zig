const TypedLinkSpecifier = @import("typed_link_specifier.zig").TypedLinkSpecifier;

/// Represents the output of a ListIncomingTypedLinks response operation.
pub const BatchListIncomingTypedLinksResponse = struct {
    /// Returns one or more typed link specifiers as output.
    link_specifiers: ?[]const TypedLinkSpecifier = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .link_specifiers = "LinkSpecifiers",
        .next_token = "NextToken",
    };
};
