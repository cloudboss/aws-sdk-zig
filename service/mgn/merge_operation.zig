const MergeConstruct = @import("merge_construct.zig").MergeConstruct;

/// An operation that merges constructs from different segments into the target
/// construct.
pub const MergeOperation = struct {
    /// The list of constructs to merge into the target.
    merge_constructs: ?[]const MergeConstruct = null,

    pub const json_field_names = .{
        .merge_constructs = "mergeConstructs",
    };
};
