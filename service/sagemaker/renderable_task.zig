/// Contains input values for a task.
pub const RenderableTask = struct {
    /// A JSON object that contains values for the variables defined in the
    /// template. It is made available to the template under the substitution
    /// variable `task.input`. For example, if you define a variable
    /// `task.input.text` in your template, you can supply the variable in the JSON
    /// object as `"text": "sample text"`.
    input: []const u8,

    pub const json_field_names = .{
        .input = "Input",
    };
};
