const FunctionSummary = @import("function_summary.zig").FunctionSummary;

/// A list of CloudFront functions.
pub const FunctionList = struct {
    /// Contains the functions in the list.
    items: ?[]const FunctionSummary,

    /// The maximum number of functions requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing functions where you left off.
    next_marker: ?[]const u8,

    /// The number of functions returned in the response.
    quantity: i32,
};
