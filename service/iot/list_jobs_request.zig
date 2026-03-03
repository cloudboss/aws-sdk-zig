const JobStatus = @import("job_status.zig").JobStatus;
const TargetSelection = @import("target_selection.zig").TargetSelection;

pub const ListJobsRequest = struct {
    /// The maximum number of results to return per request.
    max_results: ?i32 = null,

    /// The namespace used to indicate that a job is a customer-managed job.
    ///
    /// When you specify a value for this parameter, Amazon Web Services IoT Core
    /// sends jobs notifications to
    /// MQTT topics that contain the value in the following format.
    ///
    /// `$aws/things/*THING_NAME*/jobs/*JOB_ID*/notify-namespace-*NAMESPACE_ID*/`
    ///
    /// The `namespaceId` feature is only supported by IoT Greengrass at this time.
    /// For
    /// more information, see [Setting up IoT Greengrass core
    /// devices.](https://docs.aws.amazon.com/greengrass/v2/developerguide/setting-up.html)
    namespace_id: ?[]const u8 = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// An optional filter that lets you search for jobs that have the specified
    /// status.
    status: ?JobStatus = null,

    /// Specifies whether the job will continue to run (CONTINUOUS), or will be
    /// complete
    /// after all those things specified as targets have completed the job
    /// (SNAPSHOT). If
    /// continuous, the job may also be run on a thing when a change is detected in
    /// a target.
    /// For example, a job will run on a thing when the thing is added to a target
    /// group, even
    /// after the job was completed by all things originally in the group.
    ///
    /// We recommend that you use continuous jobs instead of snapshot jobs for
    /// dynamic
    /// thing group targets. By using continuous jobs, devices that join the group
    /// receive
    /// the job execution even after the job has been created.
    target_selection: ?TargetSelection = null,

    /// A filter that limits the returned jobs to those for the specified group.
    thing_group_id: ?[]const u8 = null,

    /// A filter that limits the returned jobs to those for the specified group.
    thing_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .namespace_id = "namespaceId",
        .next_token = "nextToken",
        .status = "status",
        .target_selection = "targetSelection",
        .thing_group_id = "thingGroupId",
        .thing_group_name = "thingGroupName",
    };
};
