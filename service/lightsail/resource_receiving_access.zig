/// Describes an Amazon Lightsail instance that has access to a Lightsail
/// bucket.
pub const ResourceReceivingAccess = struct {
    /// The name of the Lightsail instance.
    name: ?[]const u8,

    /// The Lightsail resource type (for example, `Instance`).
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .resource_type = "resourceType",
    };
};
