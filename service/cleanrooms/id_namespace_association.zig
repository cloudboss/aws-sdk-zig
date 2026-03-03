const IdMappingConfig = @import("id_mapping_config.zig").IdMappingConfig;
const IdNamespaceAssociationInputReferenceConfig = @import("id_namespace_association_input_reference_config.zig").IdNamespaceAssociationInputReferenceConfig;
const IdNamespaceAssociationInputReferenceProperties = @import("id_namespace_association_input_reference_properties.zig").IdNamespaceAssociationInputReferenceProperties;

/// Provides information to create the ID namespace association.
pub const IdNamespaceAssociation = struct {
    /// The Amazon Resource Name (ARN) of the ID namespace association.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains this ID
    /// namespace association.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this ID namespace
    /// association.
    collaboration_id: []const u8,

    /// The time at which the ID namespace association was created.
    create_time: i64,

    /// The description of the ID namespace association.
    description: ?[]const u8 = null,

    /// The unique identifier for this ID namespace association.
    id: []const u8,

    /// The configuration settings for the ID mapping table.
    id_mapping_config: ?IdMappingConfig = null,

    /// The input reference configuration for the ID namespace association.
    input_reference_config: IdNamespaceAssociationInputReferenceConfig,

    /// The input reference properties for the ID namespace association.
    input_reference_properties: IdNamespaceAssociationInputReferenceProperties,

    /// The Amazon Resource Name (ARN) of the membership resource for this ID
    /// namespace association.
    membership_arn: []const u8,

    /// The unique identifier of the membership resource for this ID namespace
    /// association.
    membership_id: []const u8,

    /// The name of this ID namespace association.
    name: []const u8,

    /// The most recent time at which the ID namespace association was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .id_mapping_config = "idMappingConfig",
        .input_reference_config = "inputReferenceConfig",
        .input_reference_properties = "inputReferenceProperties",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
