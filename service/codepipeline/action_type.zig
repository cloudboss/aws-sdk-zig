const ActionConfigurationProperty = @import("action_configuration_property.zig").ActionConfigurationProperty;
const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const ArtifactDetails = @import("artifact_details.zig").ArtifactDetails;
const ActionTypeSettings = @import("action_type_settings.zig").ActionTypeSettings;

/// Returns information about the details of an action type.
pub const ActionType = struct {
    /// The configuration properties for the action type.
    action_configuration_properties: ?[]const ActionConfigurationProperty = null,

    /// Represents information about an action type.
    id: ActionTypeId,

    /// The details of the input artifact for the action, such as its commit ID.
    input_artifact_details: ArtifactDetails,

    /// The details of the output artifact of the action, such as its commit ID.
    output_artifact_details: ArtifactDetails,

    /// The settings for the action type.
    settings: ?ActionTypeSettings = null,

    pub const json_field_names = .{
        .action_configuration_properties = "actionConfigurationProperties",
        .id = "id",
        .input_artifact_details = "inputArtifactDetails",
        .output_artifact_details = "outputArtifactDetails",
        .settings = "settings",
    };
};
