const PathFilter = @import("path_filter.zig").PathFilter;
const Protocol = @import("protocol.zig").Protocol;
const Tag = @import("tag.zig").Tag;

/// Describes a path.
pub const NetworkInsightsPath = struct {
    /// The time stamp when the path was created.
    created_date: ?i64 = null,

    /// The ID of the destination.
    destination: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the destination.
    destination_arn: ?[]const u8 = null,

    /// The IP address of the destination.
    destination_ip: ?[]const u8 = null,

    /// The destination port.
    destination_port: ?i32 = null,

    /// Scopes the analysis to network paths that match specific filters at the
    /// destination.
    filter_at_destination: ?PathFilter = null,

    /// Scopes the analysis to network paths that match specific filters at the
    /// source.
    filter_at_source: ?PathFilter = null,

    /// The Amazon Resource Name (ARN) of the path.
    network_insights_path_arn: ?[]const u8 = null,

    /// The ID of the path.
    network_insights_path_id: ?[]const u8 = null,

    /// The protocol.
    protocol: ?Protocol = null,

    /// The ID of the source.
    source: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the source.
    source_arn: ?[]const u8 = null,

    /// The IP address of the source.
    source_ip: ?[]const u8 = null,

    /// The tags associated with the path.
    tags: ?[]const Tag = null,
};
