const KxDataviewSegmentConfiguration = @import("kx_dataview_segment_configuration.zig").KxDataviewSegmentConfiguration;

/// The structure that stores the configuration details of a dataview.
pub const KxDataviewConfiguration = struct {
    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8 = null,

    /// The unique identifier of the dataview.
    dataview_name: ?[]const u8 = null,

    /// The version of the dataview corresponding to a given changeset.
    dataview_version_id: ?[]const u8 = null,

    /// The db path and volume configuration for the segmented database.
    segment_configurations: ?[]const KxDataviewSegmentConfiguration = null,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .dataview_name = "dataviewName",
        .dataview_version_id = "dataviewVersionId",
        .segment_configurations = "segmentConfigurations",
    };
};
