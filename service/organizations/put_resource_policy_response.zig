const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyResponse = struct {
    /// A structure that contains details about the resource policy.
    resource_policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
    };
};
