/// Specifies a transform that chooses one `DynamicFrame` from a collection of
/// `DynamicFrames`. The output is the selected `DynamicFrame`
pub const SelectFromCollection = struct {
    /// The index for the DynamicFrame to be selected.
    index: i32 = 0,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .index = "Index",
        .inputs = "Inputs",
        .name = "Name",
    };
};
