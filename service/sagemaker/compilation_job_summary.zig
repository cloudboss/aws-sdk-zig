const CompilationJobStatus = @import("compilation_job_status.zig").CompilationJobStatus;
const TargetDevice = @import("target_device.zig").TargetDevice;
const TargetPlatformAccelerator = @import("target_platform_accelerator.zig").TargetPlatformAccelerator;
const TargetPlatformArch = @import("target_platform_arch.zig").TargetPlatformArch;
const TargetPlatformOs = @import("target_platform_os.zig").TargetPlatformOs;

/// A summary of a model compilation job.
pub const CompilationJobSummary = struct {
    /// The time when the model compilation job completed.
    compilation_end_time: ?i64,

    /// The Amazon Resource Name (ARN) of the model compilation job.
    compilation_job_arn: []const u8,

    /// The name of the model compilation job that you want a summary for.
    compilation_job_name: []const u8,

    /// The status of the model compilation job.
    compilation_job_status: CompilationJobStatus,

    /// The time when the model compilation job started.
    compilation_start_time: ?i64,

    /// The type of device that the model will run on after the compilation job has
    /// completed.
    compilation_target_device: ?TargetDevice,

    /// The type of accelerator that the model will run on after the compilation job
    /// has completed.
    compilation_target_platform_accelerator: ?TargetPlatformAccelerator,

    /// The type of architecture that the model will run on after the compilation
    /// job has completed.
    compilation_target_platform_arch: ?TargetPlatformArch,

    /// The type of OS that the model will run on after the compilation job has
    /// completed.
    compilation_target_platform_os: ?TargetPlatformOs,

    /// The time when the model compilation job was created.
    creation_time: i64,

    /// The time when the model compilation job was last modified.
    last_modified_time: ?i64,

    pub const json_field_names = .{
        .compilation_end_time = "CompilationEndTime",
        .compilation_job_arn = "CompilationJobArn",
        .compilation_job_name = "CompilationJobName",
        .compilation_job_status = "CompilationJobStatus",
        .compilation_start_time = "CompilationStartTime",
        .compilation_target_device = "CompilationTargetDevice",
        .compilation_target_platform_accelerator = "CompilationTargetPlatformAccelerator",
        .compilation_target_platform_arch = "CompilationTargetPlatformArch",
        .compilation_target_platform_os = "CompilationTargetPlatformOs",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};
