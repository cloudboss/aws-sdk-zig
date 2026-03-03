const RegistryStatus = @import("registry_status.zig").RegistryStatus;

/// A structure containing the details for a registry.
pub const RegistryListItem = struct {
    /// The data the registry was created.
    created_time: ?[]const u8 = null,

    /// A description of the registry.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The status of the registry.
    status: ?RegistryStatus = null,

    /// The date the registry was updated.
    updated_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .status = "Status",
        .updated_time = "UpdatedTime",
    };
};
