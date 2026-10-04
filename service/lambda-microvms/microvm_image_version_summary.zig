const aws = @import("aws");

const Capability = @import("capability.zig").Capability;
const CodeArtifact = @import("code_artifact.zig").CodeArtifact;
const CpuConfiguration = @import("cpu_configuration.zig").CpuConfiguration;
const Hooks = @import("hooks.zig").Hooks;
const Logging = @import("logging.zig").Logging;
const Resources = @import("resources.zig").Resources;
const MicrovmImageVersionState = @import("microvm_image_version_state.zig").MicrovmImageVersionState;
const MicrovmImageVersionStatus = @import("microvm_image_version_status.zig").MicrovmImageVersionStatus;

/// Contains summary information about a version of a MicroVM image.
pub const MicrovmImageVersionSummary = struct {
    /// Additional OS capabilities granted to the MicroVM runtime environment.
    additional_os_capabilities: ?[]const Capability = null,

    /// The ARN of the base MicroVM image used.
    base_image_arn: []const u8,

    /// The specific version of the base MicroVM image.
    base_image_version: ?[]const u8 = null,

    /// The ARN of the IAM build role.
    build_role_arn: []const u8,

    /// The code artifact for this version.
    code_artifact: CodeArtifact,

    /// The list of supported CPU configurations for the MicroVM.
    cpu_configurations: ?[]const CpuConfiguration = null,

    /// The timestamp when the version was created.
    created_at: i64,

    /// The description of the version.
    description: ?[]const u8 = null,

    /// The list of egress network connectors available to the MicroVM at runtime.
    egress_network_connectors: ?[]const []const u8 = null,

    /// Environment variables set in the MicroVM runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    hooks: ?Hooks = null,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The version of the MicroVM image.
    image_version: []const u8,

    /// The logging configuration for this version.
    logging: ?Logging = null,

    /// The resource requirements for the MicroVM.
    resources: ?[]const Resources = null,

    /// The current state of the version.
    state: MicrovmImageVersionState,

    /// The reason for the current state. For example, one or more builds failed.
    state_reason: ?[]const u8 = null,

    /// The availability status of the version: ACTIVE (can be used by RunMicrovm)
    /// or INACTIVE (blocked from launching new MicroVMs).
    status: MicrovmImageVersionStatus,

    /// Key-value pairs associated with the version.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the version was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .additional_os_capabilities = "additionalOsCapabilities",
        .base_image_arn = "baseImageArn",
        .base_image_version = "baseImageVersion",
        .build_role_arn = "buildRoleArn",
        .code_artifact = "codeArtifact",
        .cpu_configurations = "cpuConfigurations",
        .created_at = "createdAt",
        .description = "description",
        .egress_network_connectors = "egressNetworkConnectors",
        .environment_variables = "environmentVariables",
        .hooks = "hooks",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .logging = "logging",
        .resources = "resources",
        .state = "state",
        .state_reason = "stateReason",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
