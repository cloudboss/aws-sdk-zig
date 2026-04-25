const aws = @import("aws");

const CustomOutputConfiguration = @import("custom_output_configuration.zig").CustomOutputConfiguration;
const DataAutomationLibraryConfiguration = @import("data_automation_library_configuration.zig").DataAutomationLibraryConfiguration;
const OverrideConfiguration = @import("override_configuration.zig").OverrideConfiguration;
const DataAutomationProjectStage = @import("data_automation_project_stage.zig").DataAutomationProjectStage;
const DataAutomationProjectType = @import("data_automation_project_type.zig").DataAutomationProjectType;
const StandardOutputConfiguration = @import("standard_output_configuration.zig").StandardOutputConfiguration;
const DataAutomationProjectStatus = @import("data_automation_project_status.zig").DataAutomationProjectStatus;

/// Contains the information of a DataAutomationProject.
pub const DataAutomationProject = struct {
    creation_time: i64,

    custom_output_configuration: ?CustomOutputConfiguration = null,

    data_automation_library_configuration: ?DataAutomationLibraryConfiguration = null,

    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    kms_key_id: ?[]const u8 = null,

    last_modified_time: i64,

    override_configuration: ?OverrideConfiguration = null,

    project_arn: []const u8,

    project_description: ?[]const u8 = null,

    project_name: []const u8,

    project_stage: ?DataAutomationProjectStage = null,

    project_type: ?DataAutomationProjectType = null,

    standard_output_configuration: ?StandardOutputConfiguration = null,

    status: DataAutomationProjectStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .custom_output_configuration = "customOutputConfiguration",
        .data_automation_library_configuration = "dataAutomationLibraryConfiguration",
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
