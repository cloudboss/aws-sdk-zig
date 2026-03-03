const GetResourcePoliciesResponseEntry = @import("get_resource_policies_response_entry.zig").GetResourcePoliciesResponseEntry;

pub const GetResourcePoliciesResponse = struct {
    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// An array of the `Policy` object.
    policies: ?[]const GetResourcePoliciesResponseEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .policies = "Policies",
    };
};
