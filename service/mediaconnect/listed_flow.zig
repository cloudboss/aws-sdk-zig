const Maintenance = @import("maintenance.zig").Maintenance;
const SourceType = @import("source_type.zig").SourceType;
const Status = @import("status.zig").Status;

/// A summary of a flow, including its ARN, Availability Zone, and source type.
pub const ListedFlow = struct {
    /// The Availability Zone that the flow was created in.
    availability_zone: []const u8,

    /// A description of the flow.
    description: []const u8,

    /// The ARN of the flow.
    flow_arn: []const u8,

    /// The maintenance settings for the flow.
    maintenance: ?Maintenance = null,

    /// The name of the flow.
    name: []const u8,

    /// The type of source. This value is either owned (originated somewhere other
    /// than an MediaConnect flow owned by another Amazon Web Services account) or
    /// entitled (originated at a MediaConnect flow owned by another Amazon Web
    /// Services account).
    source_type: SourceType,

    /// The current status of the flow.
    status: Status,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .description = "Description",
        .flow_arn = "FlowArn",
        .maintenance = "Maintenance",
        .name = "Name",
        .source_type = "SourceType",
        .status = "Status",
    };
};
