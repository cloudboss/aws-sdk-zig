const AccelerationSettings = @import("acceleration_settings.zig").AccelerationSettings;
const HopDestination = @import("hop_destination.zig").HopDestination;
const JobTemplateSettings = @import("job_template_settings.zig").JobTemplateSettings;
const StatusUpdateInterval = @import("status_update_interval.zig").StatusUpdateInterval;
const Type = @import("type.zig").Type;

/// A job template is a pre-made set of encoding instructions that you can use
/// to quickly create a job.
pub const JobTemplate = struct {
    /// Accelerated transcoding can significantly speed up jobs with long, visually
    /// complex content.
    acceleration_settings: ?AccelerationSettings,

    /// An identifier for this resource that is unique within all of AWS.
    arn: ?[]const u8,

    /// An optional category you create to organize your job templates.
    category: ?[]const u8,

    /// The timestamp in epoch seconds for Job template creation.
    created_at: ?i64,

    /// An optional description you create for each job template.
    description: ?[]const u8,

    /// Optional list of hop destinations.
    hop_destinations: ?[]const HopDestination,

    /// The timestamp in epoch seconds when the Job template was last updated.
    last_updated: ?i64,

    /// A name you create for each job template. Each name must be unique within
    /// your account.
    name: []const u8,

    /// Relative priority on the job.
    priority: ?i32,

    /// Optional. The queue that jobs created from this template are assigned to. If
    /// you don't specify this, jobs will go to the default queue.
    queue: ?[]const u8,

    /// JobTemplateSettings contains all the transcode settings saved in the
    /// template that will be applied to jobs created from it.
    settings: JobTemplateSettings,

    /// Specify how often MediaConvert sends STATUS_UPDATE events to Amazon
    /// CloudWatch Events. Set the interval, in seconds, between status updates.
    /// MediaConvert sends an update at this interval from the time the service
    /// begins processing your job to the time it completes the transcode or
    /// encounters an error.
    status_update_interval: ?StatusUpdateInterval,

    /// A job template can be of two types: system or custom. System or built-in job
    /// templates can't be modified or deleted by the user.
    @"type": ?Type,

    pub const json_field_names = .{
        .acceleration_settings = "AccelerationSettings",
        .arn = "Arn",
        .category = "Category",
        .created_at = "CreatedAt",
        .description = "Description",
        .hop_destinations = "HopDestinations",
        .last_updated = "LastUpdated",
        .name = "Name",
        .priority = "Priority",
        .queue = "Queue",
        .settings = "Settings",
        .status_update_interval = "StatusUpdateInterval",
        .@"type" = "Type",
    };
};
