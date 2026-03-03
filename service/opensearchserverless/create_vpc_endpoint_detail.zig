const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Creation details for an OpenSearch Serverless-managed interface endpoint.
/// For more information, see [Access Amazon OpenSearch Serverless using an
/// interface
/// endpoint](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/serverless-vpc.html).
pub const CreateVpcEndpointDetail = struct {
    /// The unique identifier of the endpoint.
    id: ?[]const u8 = null,

    /// The name of the endpoint.
    name: ?[]const u8 = null,

    /// The current status in the endpoint creation process.
    status: ?VpcEndpointStatus = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
