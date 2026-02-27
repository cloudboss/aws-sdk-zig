const EngineVersion = @import("engine_version.zig").EngineVersion;
const WorkGroupState = @import("work_group_state.zig").WorkGroupState;

/// The summary information for the workgroup, which includes its name, state,
/// description, and the date and time it was created.
pub const WorkGroupSummary = struct {
    /// The workgroup creation date and time.
    creation_time: ?i64,

    /// The workgroup description.
    description: ?[]const u8,

    /// The engine version setting for all queries on the workgroup. Queries on the
    /// `AmazonAthenaPreviewFunctionality` workgroup run on the preview engine
    /// regardless of this setting.
    engine_version: ?EngineVersion,

    /// The ARN of the IAM Identity Center enabled application associated with the
    /// workgroup.
    identity_center_application_arn: ?[]const u8,

    /// The name of the workgroup.
    name: ?[]const u8,

    /// The state of the workgroup.
    state: ?WorkGroupState,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .engine_version = "EngineVersion",
        .identity_center_application_arn = "IdentityCenterApplicationArn",
        .name = "Name",
        .state = "State",
    };
};
