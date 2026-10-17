/// The context for an iteration of a ForEach step.
pub const IterationContext = struct {
    /// The index of the iteration within the ForEach step.
    index: ?i32 = null,

    /// The input item that is being processed in this iteration.
    item: ?[]const u8 = null,

    /// The name of the ForEach step that generated this iteration.
    parent_step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .index = "Index",
        .item = "Item",
        .parent_step_name = "ParentStepName",
    };
};
