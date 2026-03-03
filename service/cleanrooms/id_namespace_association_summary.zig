const IdNamespaceAssociationInputReferenceConfig = @import("id_namespace_association_input_reference_config.zig").IdNamespaceAssociationInputReferenceConfig;
const IdNamespaceAssociationInputReferencePropertiesSummary = @import("id_namespace_association_input_reference_properties_summary.zig").IdNamespaceAssociationInputReferencePropertiesSummary;

/// Detailed information about the ID namespace association.
pub const IdNamespaceAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of this ID namespace association.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains this ID
    /// namespace association.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this ID namespace
    /// association.
    collaboration_id: []const u8,

    /// The time at which this ID namespace association was created.
    create_time: i64,

    /// The description of the ID namespace association.
    description: ?[]const u8 = null,

    /// The unique identifier of this ID namespace association.
    id: []const u8,

    /// The input reference configuration details for this ID namespace association.
    input_reference_config: IdNamespaceAssociationInputReferenceConfig,

    /// The input reference properties for this ID namespace association.
    input_reference_properties: IdNamespaceAssociationInputReferencePropertiesSummary,

    /// The Amazon Resource Name (ARN) of the membership resource for this ID
    /// namespace association.
    membership_arn: []const u8,

    /// The unique identifier of the membership resource for this ID namespace
    /// association.
    membership_id: []const u8,

    /// The name of the ID namespace association.
    name: []const u8,

    /// The most recent time at which this ID namespace association has been
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .input_reference_config = "inputReferenceConfig",
        .input_reference_properties = "inputReferenceProperties",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
