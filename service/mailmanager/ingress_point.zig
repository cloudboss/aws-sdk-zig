const IngressPointStatus = @import("ingress_point_status.zig").IngressPointStatus;
const IngressPointType = @import("ingress_point_type.zig").IngressPointType;

/// The structure of an ingress endpoint resource.
pub const IngressPoint = struct {
    /// The DNS A Record that identifies your ingress endpoint. Configure your DNS
    /// Mail Exchange (MX) record with this value to route emails to Mail Manager.
    a_record: ?[]const u8 = null,

    /// The identifier of the ingress endpoint resource.
    ingress_point_id: []const u8,

    /// A user friendly name for the ingress endpoint resource.
    ingress_point_name: []const u8,

    /// The status of the ingress endpoint resource.
    status: IngressPointStatus,

    /// The type of ingress endpoint resource.
    @"type": IngressPointType,

    pub const json_field_names = .{
        .a_record = "ARecord",
        .ingress_point_id = "IngressPointId",
        .ingress_point_name = "IngressPointName",
        .status = "Status",
        .@"type" = "Type",
    };
};
