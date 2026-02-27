const AggregateOperation = @import("aggregate_operation.zig").AggregateOperation;

/// Specifies a transform that groups rows by chosen fields and computes the
/// aggregated value by specified function.
pub const Aggregate = struct {
    /// Specifies the aggregate functions to be performed on specified fields.
    aggs: []const AggregateOperation,

    /// Specifies the fields to group by.
    groups: []const []const []const u8,

    /// Specifies the fields and rows to use as inputs for the aggregate transform.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .aggs = "Aggs",
        .groups = "Groups",
        .inputs = "Inputs",
        .name = "Name",
    };
};
