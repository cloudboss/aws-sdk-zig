const PathFilter = @import("path_filter.zig").PathFilter;
const Protocol = @import("protocol.zig").Protocol;
const Tag = @import("tag.zig").Tag;

/// Describes a path.
pub const NetworkInsightsPath = struct {
    /// The time stamp when the path was created.
    created_date: ?i64,

    /// The ID of the destination.
    destination: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the destination.
    destination_arn: ?[]const u8,

    /// The IP address of the destination.
    destination_ip: ?[]const u8,

    /// The destination port.
    destination_port: ?i32,

    /// Scopes the analysis to network paths that match specific filters at the
    /// destination.
    filter_at_destination: ?PathFilter,

    /// Scopes the analysis to network paths that match specific filters at the
    /// source.
    filter_at_source: ?PathFilter,

    /// The Amazon Resource Name (ARN) of the path.
    network_insights_path_arn: ?[]const u8,

    /// The ID of the path.
    network_insights_path_id: ?[]const u8,

    /// The protocol.
    protocol: ?Protocol,

    /// The ID of the source.
    source: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source.
    source_arn: ?[]const u8,

    /// The IP address of the source.
    source_ip: ?[]const u8,

    /// The tags associated with the path.
    tags: ?[]const Tag,
};
