const DataRepositoryTaskFailureDetails = @import("data_repository_task_failure_details.zig").DataRepositoryTaskFailureDetails;
const DataRepositoryTaskLifecycle = @import("data_repository_task_lifecycle.zig").DataRepositoryTaskLifecycle;
const ReleaseConfiguration = @import("release_configuration.zig").ReleaseConfiguration;
const CompletionReport = @import("completion_report.zig").CompletionReport;
const DataRepositoryTaskStatus = @import("data_repository_task_status.zig").DataRepositoryTaskStatus;
const Tag = @import("tag.zig").Tag;
const DataRepositoryTaskType = @import("data_repository_task_type.zig").DataRepositoryTaskType;

/// A description of the data repository task.
///
/// * You use import and export data repository tasks to perform
/// bulk transfer operations between an Amazon FSx for Lustre file system
/// and a linked data repository.
///
/// * You use release data repository tasks to release files that have been
///   exported
/// to a linked S3 bucket from your Amazon FSx for Lustre file system.
///
/// * An Amazon File Cache resource uses a task to automatically
/// release files from the cache.
///
/// To learn more about data repository tasks, see
/// [Data Repository
/// Tasks](https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-repository-tasks.html).
pub const DataRepositoryTask = struct {
    /// Specifies the amount of data to release, in GiB, by an Amazon File Cache
    /// AUTO_RELEASE_DATA task that automatically releases files from the cache.
    capacity_to_release: ?i64,

    creation_time: i64,

    /// The time the system completed processing the task, populated after the task
    /// is complete.
    end_time: ?i64,

    /// Failure message describing why the task failed, it is populated only when
    /// `Lifecycle` is set to `FAILED`.
    failure_details: ?DataRepositoryTaskFailureDetails,

    /// The system-generated, unique ID of the cache.
    file_cache_id: ?[]const u8,

    /// The globally unique ID of the file system.
    file_system_id: ?[]const u8,

    /// The lifecycle status of the data repository task, as follows:
    ///
    /// * `PENDING` - The task has not started.
    ///
    /// * `EXECUTING` - The task is in process.
    ///
    /// * `FAILED` - The task was not able to be completed. For example, there may
    ///   be files the task failed to process.
    /// The DataRepositoryTaskFailureDetails property provides more information
    /// about task failures.
    ///
    /// * `SUCCEEDED` - The task has completed successfully.
    ///
    /// * `CANCELED` - The task was canceled and it did not complete.
    ///
    /// * `CANCELING` - The task is in process of being canceled.
    ///
    /// You cannot delete an FSx for Lustre file system if there are data
    /// repository tasks for the file system in the `PENDING` or `EXECUTING` states.
    /// Please retry when the data repository task is finished (with a status of
    /// `CANCELED`, `SUCCEEDED`, or `FAILED`).
    /// You can use the DescribeDataRepositoryTask action to monitor the task
    /// status. Contact the FSx team if you need to delete your file system
    /// immediately.
    lifecycle: DataRepositoryTaskLifecycle,

    /// An array of paths that specify the data for the data repository task to
    /// process.
    /// For example, in an EXPORT_TO_REPOSITORY task, the paths specify which data
    /// to export
    /// to the linked data repository.
    ///
    /// (Default) If `Paths` is not specified, Amazon FSx uses the file system root
    /// directory.
    paths: ?[]const []const u8,

    /// The configuration that specifies the last accessed time criteria for files
    /// that will be released from an Amazon FSx for Lustre file system.
    release_configuration: ?ReleaseConfiguration,

    report: ?CompletionReport,

    resource_arn: ?[]const u8,

    /// The time the system began processing the task.
    start_time: ?i64,

    /// Provides the status of the number of files that the task has processed
    /// successfully and failed to process.
    status: ?DataRepositoryTaskStatus,

    tags: ?[]const Tag,

    /// The system-generated, unique 17-digit ID of the data repository task.
    task_id: []const u8,

    /// The type of data repository task.
    ///
    /// * `EXPORT_TO_REPOSITORY` tasks export from your
    /// Amazon FSx for Lustre file system to a linked data repository.
    ///
    /// * `IMPORT_METADATA_FROM_REPOSITORY` tasks import metadata
    /// changes from a linked S3 bucket to your Amazon FSx for Lustre file system.
    ///
    /// * `RELEASE_DATA_FROM_FILESYSTEM` tasks release files in
    /// your Amazon FSx for Lustre file system that have been exported to a
    /// linked S3 bucket and that meet your specified release criteria.
    ///
    /// * `AUTO_RELEASE_DATA` tasks automatically release files from
    /// an Amazon File Cache resource.
    @"type": DataRepositoryTaskType,

    pub const json_field_names = .{
        .capacity_to_release = "CapacityToRelease",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .failure_details = "FailureDetails",
        .file_cache_id = "FileCacheId",
        .file_system_id = "FileSystemId",
        .lifecycle = "Lifecycle",
        .paths = "Paths",
        .release_configuration = "ReleaseConfiguration",
        .report = "Report",
        .resource_arn = "ResourceARN",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
        .task_id = "TaskId",
        .@"type" = "Type",
    };
};
