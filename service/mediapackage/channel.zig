const aws = @import("aws");

const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;
const HlsIngest = @import("hls_ingest.zig").HlsIngest;
const IngressAccessLogs = @import("ingress_access_logs.zig").IngressAccessLogs;

/// A Channel resource configuration.
pub const Channel = struct {
    /// The Amazon Resource Name (ARN) assigned to the Channel.
    arn: ?[]const u8 = null,

    /// The date and time the Channel was created.
    created_at: ?[]const u8 = null,

    /// A short text description of the Channel.
    description: ?[]const u8 = null,

    egress_access_logs: ?EgressAccessLogs = null,

    hls_ingest: ?HlsIngest = null,

    /// The ID of the Channel.
    id: ?[]const u8 = null,

    ingress_access_logs: ?IngressAccessLogs = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .egress_access_logs = "EgressAccessLogs",
        .hls_ingest = "HlsIngest",
        .id = "Id",
        .ingress_access_logs = "IngressAccessLogs",
        .tags = "Tags",
    };
};
