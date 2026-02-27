const RegistryStatus = @import("registry_status.zig").RegistryStatus;

/// A structure containing the details for a registry.
pub const RegistryListItem = struct {
    /// The data the registry was created.
    created_time: ?[]const u8,

    /// A description of the registry.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8,

    /// The name of the registry.
    registry_name: ?[]const u8,

    /// The status of the registry.
    status: ?RegistryStatus,

    /// The date the registry was updated.
    updated_time: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .status = "Status",
        .updated_time = "UpdatedTime",
    };
};
