const aws = @import("aws");

/// vCenter client.
pub const VcenterClient = struct {
    /// Arn of vCenter client.
    arn: ?[]const u8,

    /// Datacenter name of vCenter client.
    datacenter_name: ?[]const u8,

    /// Hostname of vCenter client .
    hostname: ?[]const u8,

    /// Last seen time of vCenter client.
    last_seen_datetime: ?[]const u8,

    /// Tags for Source Server of vCenter client.
    source_server_tags: ?[]const aws.map.StringMapEntry,

    /// Tags for vCenter client.
    tags: ?[]const aws.map.StringMapEntry,

    /// ID of vCenter client.
    vcenter_client_id: ?[]const u8,

    /// Vcenter UUID of vCenter client.
    vcenter_uuid: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .datacenter_name = "datacenterName",
        .hostname = "hostname",
        .last_seen_datetime = "lastSeenDatetime",
        .source_server_tags = "sourceServerTags",
        .tags = "tags",
        .vcenter_client_id = "vcenterClientID",
        .vcenter_uuid = "vcenterUUID",
    };
};
