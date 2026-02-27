const OutpostResolverStatus = @import("outpost_resolver_status.zig").OutpostResolverStatus;

/// A complex type that contains settings for an existing Resolver on an
/// Outpost.
pub const OutpostResolver = struct {
    /// The ARN (Amazon Resource Name) for the Resolver on an Outpost.
    arn: ?[]const u8,

    /// The date and time that the Outpost Resolver was created, in Unix time format
    /// and Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string that identifies the request that created the Resolver
    /// endpoint.
    /// The `CreatorRequestId` allows failed requests to be retried without the risk
    /// of running the operation twice.
    creator_request_id: ?[]const u8,

    /// The ID of the Resolver on Outpost.
    id: ?[]const u8,

    /// Amazon EC2 instance count for the Resolver on the Outpost.
    instance_count: ?i32,

    /// The date and time that the Outpost Resolver was modified, in Unix time
    /// format and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// Name of the Resolver.
    name: ?[]const u8,

    /// The ARN (Amazon Resource Name) for the Outpost.
    outpost_arn: ?[]const u8,

    /// The Amazon EC2 instance type.
    preferred_instance_type: ?[]const u8,

    /// Status of the Resolver.
    status: ?OutpostResolverStatus,

    /// A detailed description of the Resolver.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .id = "Id",
        .instance_count = "InstanceCount",
        .modification_time = "ModificationTime",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .preferred_instance_type = "PreferredInstanceType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
