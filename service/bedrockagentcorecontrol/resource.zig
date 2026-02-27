/// Represents a resource within the AgentCore Policy system. Resources are the
/// targets of policy evaluation. Currently, only AgentCore Gateways are
/// supported as resources for policy enforcement.
pub const Resource = union(enum) {
    /// The Amazon Resource Name (ARN) of the resource. This globally unique
    /// identifier specifies the exact resource that policies will be evaluated
    /// against for access control decisions.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
