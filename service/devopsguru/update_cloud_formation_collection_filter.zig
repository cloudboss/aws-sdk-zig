/// Contains the names of Amazon Web Services CloudFormation stacks used to
/// update a collection of stacks.
/// You can specify up to 500 Amazon Web Services CloudFormation stacks.
pub const UpdateCloudFormationCollectionFilter = struct {
    /// An array of the names of the Amazon Web Services CloudFormation stacks to
    /// update. You can specify up to 500 Amazon Web Services CloudFormation stacks.
    stack_names: ?[]const []const u8,

    pub const json_field_names = .{
        .stack_names = "StackNames",
    };
};
