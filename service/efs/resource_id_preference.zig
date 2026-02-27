const ResourceIdType = @import("resource_id_type.zig").ResourceIdType;
const Resource = @import("resource.zig").Resource;

/// Describes the resource type and its ID preference for the user's Amazon Web
/// Services account, in the current Amazon Web Services Region.
pub const ResourceIdPreference = struct {
    /// Identifies the EFS resource ID preference, either `LONG_ID` (17
    /// characters) or `SHORT_ID` (8 characters).
    resource_id_type: ?ResourceIdType,

    /// Identifies the Amazon EFS resources to which the ID preference setting
    /// applies, `FILE_SYSTEM` and `MOUNT_TARGET`.
    resources: ?[]const Resource,

    pub const json_field_names = .{
        .resource_id_type = "ResourceIdType",
        .resources = "Resources",
    };
};
