const Selector = @import("selector.zig").Selector;

/// Defines the query to run against an object.
pub const Query = struct {
    /// List of selectors that define the query. An object must satisfy all of the
    /// selectors to match the query.
    selectors: ?[]const Selector,

    pub const json_field_names = .{
        .selectors = "selectors",
    };
};
