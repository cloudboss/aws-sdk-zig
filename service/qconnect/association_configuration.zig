const AssociationConfigurationData = @import("association_configuration_data.zig").AssociationConfigurationData;
const AIAgentAssociationConfigurationType = @import("ai_agent_association_configuration_type.zig").AIAgentAssociationConfigurationType;

/// The configuration for an Amazon Q in Connect Assistant Association.
pub const AssociationConfiguration = struct {
    /// The data of the configuration for an Amazon Q in Connect Assistant
    /// Association.
    association_configuration_data: ?AssociationConfigurationData,

    /// The identifier of the association for this Association Configuration.
    association_id: ?[]const u8,

    /// The type of the association for this Association Configuration.
    association_type: ?AIAgentAssociationConfigurationType,

    pub const json_field_names = .{
        .association_configuration_data = "associationConfigurationData",
        .association_id = "associationId",
        .association_type = "associationType",
    };
};
