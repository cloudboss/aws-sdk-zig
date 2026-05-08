const SplitConstruct = @import("split_construct.zig").SplitConstruct;

/// An operation that splits a construct into multiple constructs with different
/// CIDR blocks.
pub const SplitOperation = struct {
    /// The list of split targets with their CIDR blocks.
    split_constructs: ?[]const SplitConstruct = null,

    pub const json_field_names = .{
        .split_constructs = "splitConstructs",
    };
};
