const aws = @import("aws");

const ApplicationAggregatedStatus = @import("application_aggregated_status.zig").ApplicationAggregatedStatus;

pub const Application = struct {
    /// Application aggregated status.
    application_aggregated_status: ?ApplicationAggregatedStatus = null,

    /// Application ID.
    application_id: ?[]const u8 = null,

    /// Application ARN.
    arn: ?[]const u8 = null,

    /// Application creation dateTime.
    creation_date_time: ?[]const u8 = null,

    /// Application description.
    description: ?[]const u8 = null,

    /// Application archival status.
    is_archived: ?bool = null,

    /// Application last modified dateTime.
    last_modified_date_time: ?[]const u8 = null,

    /// Application name.
    name: ?[]const u8 = null,

    /// Application tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Application wave ID.
    wave_id: ?[]const u8 = null,

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
