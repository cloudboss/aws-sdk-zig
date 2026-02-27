const ActionTypeExecutor = @import("action_type_executor.zig").ActionTypeExecutor;
const ActionTypeIdentifier = @import("action_type_identifier.zig").ActionTypeIdentifier;
const ActionTypeArtifactDetails = @import("action_type_artifact_details.zig").ActionTypeArtifactDetails;
const ActionTypePermissions = @import("action_type_permissions.zig").ActionTypePermissions;
const ActionTypeProperty = @import("action_type_property.zig").ActionTypeProperty;
const ActionTypeUrls = @import("action_type_urls.zig").ActionTypeUrls;

/// The parameters for the action type definition that are provided when the
/// action type
/// is created or updated.
pub const ActionTypeDeclaration = struct {
    /// The description for the action type to be updated.
    description: ?[]const u8,

    /// Information about the executor for an action type that was created with any
    /// supported
    /// integration model.
    executor: ActionTypeExecutor,

    /// The action category, owner, provider, and version of the action type to be
    /// updated.
    id: ActionTypeIdentifier,

    /// Details for the artifacts, such as application files, to be worked on by the
    /// action.
    /// For example, the minimum and maximum number of input artifacts allowed.
    input_artifact_details: ActionTypeArtifactDetails,

    /// Details for the output artifacts, such as a built application, that are the
    /// result of
    /// the action. For example, the minimum and maximum number of output artifacts
    /// allowed.
    output_artifact_details: ActionTypeArtifactDetails,

    /// Details identifying the accounts with permissions to use the action type.
    permissions: ?ActionTypePermissions,

    /// The properties of the action type to be updated.
    properties: ?[]const ActionTypeProperty,

    /// The links associated with the action type to be updated.
    urls: ?ActionTypeUrls,

    pub const json_field_names = .{
        .description = "description",
        .executor = "executor",
        .id = "id",
        .input_artifact_details = "inputArtifactDetails",
        .output_artifact_details = "outputArtifactDetails",
        .permissions = "permissions",
        .properties = "properties",
        .urls = "urls",
    };
};
