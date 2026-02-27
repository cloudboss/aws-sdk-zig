/// Provides the information for the ID namespace association input reference
/// configuration.
pub const IdNamespaceAssociationInputReferenceConfig = struct {
    /// The Amazon Resource Name (ARN) of the Entity Resolution resource that is
    /// being associated to the collaboration. Valid resource ARNs are from the ID
    /// namespaces that you own.
    input_reference_arn: []const u8,

    /// When `TRUE`, Clean Rooms manages permissions for the ID namespace
    /// association resource.
    ///
    /// When `FALSE`, the resource owner manages permissions for the ID namespace
    /// association resource.
    manage_resource_policies: bool,

    pub const json_field_names = .{
        .input_reference_arn = "inputReferenceArn",
        .manage_resource_policies = "manageResourcePolicies",
    };
};
