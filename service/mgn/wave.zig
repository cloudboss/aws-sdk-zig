const aws = @import("aws");

const WaveAggregatedStatus = @import("wave_aggregated_status.zig").WaveAggregatedStatus;

pub const Wave = struct {
    /// Wave ARN.
    arn: ?[]const u8,

    /// Wave creation dateTime.
    creation_date_time: ?[]const u8,

    /// Wave description.
    description: ?[]const u8,

    /// Wave archival status.
    is_archived: ?bool,

    /// Wave last modified dateTime.
    last_modified_date_time: ?[]const u8,

    /// Wave name.
    name: ?[]const u8,

    /// Wave tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// Wave aggregated status.
    wave_aggregated_status: ?WaveAggregatedStatus,

    /// Wave ID.
    wave_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .is_archived = "isArchived",
        .last_modified_date_time = "lastModifiedDateTime",
        .name = "name",
        .tags = "tags",
        .wave_aggregated_status = "waveAggregatedStatus",
        .wave_id = "waveID",
    };
};
