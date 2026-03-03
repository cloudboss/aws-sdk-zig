const aws = @import("aws");

const Authorization = @import("authorization.zig").Authorization;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;

/// A MediaPackage VOD PackagingGroup resource.
pub const PackagingGroup = struct {
    /// The approximate asset count of the PackagingGroup.
    approximate_asset_count: ?i32 = null,

    /// The ARN of the PackagingGroup.
    arn: ?[]const u8 = null,

    authorization: ?Authorization = null,

    /// The time the PackagingGroup was created.
    created_at: ?[]const u8 = null,

    /// The fully qualified domain name for Assets in the PackagingGroup.
    domain_name: ?[]const u8 = null,

    egress_access_logs: ?EgressAccessLogs = null,

    /// The ID of the PackagingGroup.
    id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

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
