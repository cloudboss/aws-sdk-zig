const aws = @import("aws");

const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const OverrideConfiguration = @import("override_configuration.zig").OverrideConfiguration;
const DataAutomationProjectStage = @import("data_automation_project_stage.zig").DataAutomationProjectStage;
const DataAutomationProjectType = @import("data_automation_project_type.zig").DataAutomationProjectType;
const StandardOutputConfiguration = @import("standard_output_configuration.zig").StandardOutputConfiguration;
const DataAutomationProjectStatus = @import("data_automation_project_status.zig").DataAutomationProjectStatus;

/// Contains the information of a DataAutomationProject.
pub const DataAutomationProject = struct {
    creation_time: i64,

    custom_output_configuration: ?CustomOutputConfiguration,

    kms_encryption_context: ?[]const aws.map.StringMapEntry,

    kms_key_id: ?[]const u8,

    last_modified_time: i64,

    override_configuration: ?OverrideConfiguration,

    project_arn: []const u8,

    project_description: ?[]const u8,

    project_name: []const u8,

    project_stage: ?DataAutomationProjectStage,

    project_type: ?DataAutomationProjectType,

    standard_output_configuration: ?StandardOutputConfiguration,

    status: DataAutomationProjectStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .custom_output_configuration = "customOutputConfiguration",
        .kms_encryption_context = "kmsEncryptionContext",
        .kms_key_id = "kmsKeyId",
        .last_modified_time = "lastModifiedTime",
        .override_configuration = "overrideConfiguration",
        .project_arn = "projectArn",
        .project_description = "projectDescription",
        .project_name = "projectName",
        .project_stage = "projectStage",
        .project_type = "projectType",
        .standard_output_configuration = "standardOutputConfiguration",
        .status = "status",
    };
};
