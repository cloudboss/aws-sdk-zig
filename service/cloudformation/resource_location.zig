/// The location of the resource in a stack template.
pub const ResourceLocation = struct {
    /// The logical name of the resource specified in the template.
    logical_resource_id: []const u8,

    /// The name associated with the stack.
    stack_name: []const u8,
};
