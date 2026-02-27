/// A request for the client to execute a specific tool with given parameters.
pub const Call = struct {
    /// A unique identifier for this tool call, used to match results back to
    /// requests.
    call_id: []const u8,

    /// The input parameters for the tool call, formatted according to the tool's
    /// schema.
    input: []const u8,

    /// The name of the tool to invoke, following the pattern 'tool.{toolName}' or
    /// 'browser.{browserAction}'.
    name: []const u8,

    pub const json_field_names = .{
        .call_id = "callId",
        .input = "input",
        .name = "name",
    };
};
