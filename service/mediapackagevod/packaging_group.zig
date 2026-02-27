const aws = @import("aws");

const Authorization = @import("authorization.zig").Authorization;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;

/// A MediaPackage VOD PackagingGroup resource.
pub const PackagingGroup = struct {
    /// The approximate asset count of the PackagingGroup.
    approximate_asset_count: ?i32,

    /// The ARN of the PackagingGroup.
    arn: ?[]const u8,

    authorization: ?Authorization,

    /// The time the PackagingGroup was created.
    created_at: ?[]const u8,

    /// The fully qualified domain name for Assets in the PackagingGroup.
    domain_name: ?[]const u8,

    egress_access_logs: ?EgressAccessLogs,

    /// The ID of the PackagingGroup.
    id: ?[]const u8,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .approximate_asset_count = "ApproximateAssetCount",
        .arn = "Arn",
        .authorization = "Authorization",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .egress_access_logs = "EgressAccessLogs",
        .id = "Id",
        .tags = "Tags",
    };
};
