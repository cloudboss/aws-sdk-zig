const PathElement = @import("path_element.zig").PathElement;
const Span = @import("span.zig").Span;

/// A location in a policy that is represented as a path through the JSON
/// representation and a corresponding span.
pub const Location = struct {
    /// A path in a policy, represented as a sequence of path elements.
    path: []const PathElement,

    /// A span in a policy.
    span: Span,

    pub const json_field_names = .{
        .path = "path",
        .span = "span",
    };
};
