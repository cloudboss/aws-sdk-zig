const PlatformCommand = @import("platform_command.zig").PlatformCommand;
const RunEnvironment = @import("run_environment.zig").RunEnvironment;
const PlatformScriptKey = @import("platform_script_key.zig").PlatformScriptKey;
const TargetType = @import("target_type.zig").TargetType;

/// The custom script to run tests on source or target environments.
pub const WorkflowStepAutomationConfiguration = struct {
    /// The command required to run the script.
    command: ?PlatformCommand = null,

    /// The source or target environment.
    run_environment: ?RunEnvironment = null,

    /// The Amazon S3 bucket where the script is located.
    script_location_s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key for the script location.
    script_location_s3_key: ?PlatformScriptKey = null,

    /// The servers on which to run the script.
    target_type: ?TargetType = null,

    pub const json_field_names = .{
        .command = "command",
        .run_environment = "runEnvironment",
        .script_location_s3_bucket = "scriptLocationS3Bucket",
        .script_location_s3_key = "scriptLocationS3Key",
        .target_type = "targetType",
    };
};
