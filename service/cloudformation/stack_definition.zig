/// Describes the stack and the template used by the stack.
pub const StackDefinition = struct {
    /// The name associated with the stack.
    stack_name: ?[]const u8,

    /// The file path for the stack template file.
    template_body: ?[]const u8,

    /// The desired final state of the stack template.
    template_url: ?[]const u8,
};
