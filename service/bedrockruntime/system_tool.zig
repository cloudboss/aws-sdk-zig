/// Specifies a system-defined tool for the model to use. *System-defined tools*
/// are tools that are created and provided by the model provider.
pub const SystemTool = struct {
    /// The name of the system-defined tool that you want to call.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
