const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;

/// The Lightsail resource that `SetupHistory` was ran on.
pub const SetupHistoryResource = struct {
    /// The Amazon Resource Name (ARN) of the Lightsail resource.
    arn: ?[]const u8,

    /// The timestamp for when the resource was created.
    created_at: ?i64,

    location: ?ResourceLocation,

    /// The name of the Lightsail resource.
    name: ?[]const u8,

    /// The Lightsail resource type. For example, `Instance`.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
    };
};
