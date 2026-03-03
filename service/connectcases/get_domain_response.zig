const aws = @import("aws");

const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const GetDomainResponse = struct {
    /// The timestamp when the Cases domain was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the Cases domain.
    domain_arn: []const u8,

    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// The status of the Cases domain.
    domain_status: DomainStatus,

    /// The name of the Cases domain.
    name: []const u8,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .domain_arn = "domainArn",
        .domain_id = "domainId",
        .domain_status = "domainStatus",
        .name = "name",
        .tags = "tags",
    };
};
