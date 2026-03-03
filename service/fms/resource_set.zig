const ResourceSetStatus = @import("resource_set_status.zig").ResourceSetStatus;

/// A set of resources to include in a policy.
pub const ResourceSet = struct {
    /// A description of the resource set.
    description: ?[]const u8 = null,

    /// A unique identifier for the resource set. This ID is returned in the
    /// responses to create and list commands. You provide it to operations like
    /// update and delete.
    id: ?[]const u8 = null,

    /// The last time that the resource set was changed.
    last_update_time: ?i64 = null,

    /// The descriptive name of the resource set. You can't change the name of a
    /// resource set after you create it.
    name: []const u8,

    /// Indicates whether the resource set is in or out of an admin's Region scope.
    ///
    /// * `ACTIVE` - The administrator can manage and delete the resource set.
    ///
    /// * `OUT_OF_ADMIN_SCOPE` - The administrator can view the resource set, but
    ///   they can't edit or delete the resource set. Existing protections stay in
    ///   place. Any new resource that come into scope of the resource set won't be
    ///   protected.
    resource_set_status: ?ResourceSetStatus = null,

    /// Determines the resources that can be associated to the resource set.
    /// Depending on
    /// your setting for max results and the number of resource sets, a single call
    /// might not
    /// return the full list.
    resource_type_list: []const []const u8,

    /// An optional token that you can use for optimistic locking. Firewall Manager
    /// returns a token to your requests that access the resource set. The token
    /// marks the state of the resource set resource at the time of the request.
    /// Update tokens are not allowed when creating a resource set. After creation,
    /// each subsequent update call to the resource set requires the update token.
    ///
    /// To make an unconditional change to the resource set, omit the token in your
    /// update request. Without the token, Firewall Manager performs your updates
    /// regardless of whether the resource set has changed since you last retrieved
    /// it.
    ///
    /// To make a conditional change to the resource set, provide the token in your
    /// update request. Firewall Manager uses the token to ensure that the resource
    /// set hasn't changed since you last retrieved it. If it has changed, the
    /// operation fails with an `InvalidTokenException`. If this happens, retrieve
    /// the resource set again to get a current copy of it with a new token. Reapply
    /// your changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
        .resource_set_status = "ResourceSetStatus",
        .resource_type_list = "ResourceTypeList",
        .update_token = "UpdateToken",
    };
};
