const aws = @import("aws");

const ApplicationAggregatedStatus = @import("application_aggregated_status.zig").ApplicationAggregatedStatus;

pub const Application = struct {
    /// Application aggregated status.
    application_aggregated_status: ?ApplicationAggregatedStatus,

    /// Application ID.
    application_id: ?[]const u8,

    /// Application ARN.
    arn: ?[]const u8,

    /// Application creation dateTime.
    creation_date_time: ?[]const u8,

    /// Application description.
    description: ?[]const u8,

    /// Application archival status.
    is_archived: ?bool,

    /// Application last modified dateTime.
    last_modified_date_time: ?[]const u8,

    /// Application name.
    name: ?[]const u8,

    /// Application tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// Application wave ID.
    wave_id: ?[]const u8,

    pub const json_field_names = .{
        .application_aggregated_status = "applicationAggregatedStatus",
        .application_id = "applicationID",
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .is_archived = "isArchived",
        .last_modified_date_time = "lastModifiedDateTime",
        .name = "name",
        .tags = "tags",
        .wave_id = "waveID",
    };
};
