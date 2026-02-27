const aws = @import("aws");

const ExternalInvocationConfiguration = @import("external_invocation_configuration.zig").ExternalInvocationConfiguration;
const ContactFlowModuleState = @import("contact_flow_module_state.zig").ContactFlowModuleState;
const ContactFlowModuleStatus = @import("contact_flow_module_status.zig").ContactFlowModuleStatus;

/// Contains information about a flow module.
pub const ContactFlowModule = struct {
    /// The Amazon Resource Name (ARN).
    arn: ?[]const u8,

    /// The JSON string that represents the content of the flow. For an example, see
    /// [Example
    /// flow in Amazon Connect Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language-example.html).
    content: ?[]const u8,

    /// The description of the flow module.
    description: ?[]const u8,

    /// The external invocation configuration for the flow module
    external_invocation_configuration: ?ExternalInvocationConfiguration,

    /// Hash of the module content for integrity verification.
    flow_module_content_sha_256: ?[]const u8,

    /// The identifier of the flow module.
    id: ?[]const u8,

    /// The name of the flow module.
    name: ?[]const u8,

    /// The configuration settings for the flow module.
    settings: ?[]const u8,

    /// The type of flow module.
    state: ?ContactFlowModuleState,

    /// The status of the flow module.
    status: ?ContactFlowModuleStatus,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry,

    /// The version of the flow module.
    version: ?i64,

    /// Description of the version.
    version_description: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .description = "Description",
        .external_invocation_configuration = "ExternalInvocationConfiguration",
        .flow_module_content_sha_256 = "FlowModuleContentSha256",
        .id = "Id",
        .name = "Name",
        .settings = "Settings",
        .state = "State",
        .status = "Status",
        .tags = "Tags",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
