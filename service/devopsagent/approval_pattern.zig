const aws = @import("aws");

/// Tool-invocation pattern primitive used to express both an agent-requested
/// approval and a finalized approval. The primitive is uniform across AWS and
/// third-party tools: a tool identifier plus a map of argument pins that narrow
/// which invocations the pattern matches.
pub const ApprovalPattern = struct {
    /// Argument constraints that narrow which tool invocations the pattern matches.
    /// For AWS tools, the map must include `operation` (the IAM action, e.g.
    /// `ec2:AuthorizeSecurityGroupIngress`) and `resource_arn` (the resource ARN or
    /// ARN glob); additional narrowing arguments go in further pin keys. The same
    /// `{tool, argumentPins}` shape is used uniformly for AWS and third-party
    /// tools, with tool-specific keys for third-party tools. Requests whose
    /// argument pins are collectively too large are rejected with a
    /// ValidationException.
    argument_pins: []const aws.map.StringMapEntry,

    /// Identifier of the tool the pattern applies to (e.g. `use_aws` for AWS
    /// actions, or a third-party tool name).
    tool: []const u8,

    pub const json_field_names = .{
        .argument_pins = "argumentPins",
        .tool = "tool",
    };
};
