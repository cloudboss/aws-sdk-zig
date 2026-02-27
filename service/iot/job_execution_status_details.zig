const aws = @import("aws");

/// Details of the job execution status.
pub const JobExecutionStatusDetails = struct {
    /// The job execution status.
    details_map: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .details_map = "detailsMap",
    };
};
