/// Provides the input reference configuration for the ID mapping table.
pub const IdMappingTableInputReferenceConfig = struct {
    /// The Amazon Resource Name (ARN) of the referenced resource in Entity
    /// Resolution. Valid values are ID mapping workflow ARNs.
    input_reference_arn: []const u8,

    /// When `TRUE`, Clean Rooms manages permissions for the ID mapping table
    /// resource.
    ///
    /// When `FALSE`, the resource owner manages permissions for the ID mapping
    /// table resource.
    manage_resource_policies: bool,

    pub const json_field_names = .{
        .input_reference_arn = "inputReferenceArn",
        .manage_resource_policies = "manageResourcePolicies",
    };
};
