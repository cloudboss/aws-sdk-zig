const IdNamespaceAssociationInputReferenceConfig = @import("id_namespace_association_input_reference_config.zig").IdNamespaceAssociationInputReferenceConfig;
const IdNamespaceAssociationInputReferencePropertiesSummary = @import("id_namespace_association_input_reference_properties_summary.zig").IdNamespaceAssociationInputReferencePropertiesSummary;

/// Provides summary information about the collaboration ID namespace
/// association.
pub const CollaborationIdNamespaceAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the collaboration ID namespace
    /// association.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains this
    /// collaboration ID namespace association.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this collaboration
    /// ID namespace association.
    collaboration_id: []const u8,

    /// The time at which the collaboration ID namespace association was created.
    create_time: i64,

    /// The Amazon Web Services account that created this collaboration ID namespace
    /// association.
    creator_account_id: []const u8,

    /// The description of the collaboration ID namepsace association.
    description: ?[]const u8 = null,

    /// The unique identifier of the collaboration ID namespace association.
    id: []const u8,

    /// The input reference configuration that's used to create the collaboration ID
    /// namespace association.
    input_reference_config: IdNamespaceAssociationInputReferenceConfig,

    /// The input reference properties that are used to create the collaboration ID
    /// namespace association.
    input_reference_properties: IdNamespaceAssociationInputReferencePropertiesSummary,

    /// The name of the collaboration ID namespace association.
    name: []const u8,

    /// The most recent time at which the collaboration ID namespace association was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .id = "id",
        .input_reference_config = "inputReferenceConfig",
        .input_reference_properties = "inputReferenceProperties",
        .name = "name",
        .update_time = "updateTime",
    };
};
