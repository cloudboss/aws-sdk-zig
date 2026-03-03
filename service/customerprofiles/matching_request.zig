const AutoMerging = @import("auto_merging.zig").AutoMerging;
const ExportingConfig = @import("exporting_config.zig").ExportingConfig;
const JobSchedule = @import("job_schedule.zig").JobSchedule;

/// The flag that enables the matching process of duplicate profiles.
pub const MatchingRequest = struct {
    /// Configuration information about the auto-merging process.
    auto_merging: ?AutoMerging = null,

    /// The flag that enables the matching process of duplicate profiles.
    enabled: bool,

    /// Configuration information for exporting Identity Resolution results, for
    /// example, to an S3
    /// bucket.
    exporting_config: ?ExportingConfig = null,

    /// The day and time when do you want to start the Identity Resolution Job every
    /// week.
    job_schedule: ?JobSchedule = null,

    pub const json_field_names = .{
        .auto_merging = "AutoMerging",
        .enabled = "Enabled",
        .exporting_config = "ExportingConfig",
        .job_schedule = "JobSchedule",
    };
};
