/// A structure that identifies a resource that is currently pending addition to
/// the group
/// as a member. Adding a resource to a resource group happens asynchronously as
/// a
/// background task and this one isn't completed yet.
pub const PendingResource = struct {
    /// The Amazon resource name (ARN) of the resource that's in a pending state.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
