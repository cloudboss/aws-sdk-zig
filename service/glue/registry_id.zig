/// A wrapper structure that may contain the registry name and Amazon Resource
/// Name (ARN).
pub const RegistryId = struct {
    /// Arn of the registry to be updated. One of `RegistryArn` or `RegistryName`
    /// has to be provided.
    registry_arn: ?[]const u8,

    /// Name of the registry. Used only for lookup. One of `RegistryArn` or
    /// `RegistryName` has to be provided.
    registry_name: ?[]const u8,

    pub const json_field_names = .{
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
    };
};
