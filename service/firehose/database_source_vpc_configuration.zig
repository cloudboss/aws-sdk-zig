/// The structure for details of the VPC Endpoint Service which Firehose uses to
/// create a PrivateLink to the database.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const DatabaseSourceVPCConfiguration = struct {
    /// The VPC endpoint service name which Firehose uses to create a PrivateLink to
    /// the database. The endpoint service must have the Firehose service principle
    /// `firehose.amazonaws.com` as an allowed principal on the VPC endpoint
    /// service. The VPC endpoint service name is a string that looks like
    /// `com.amazonaws.vpce..`.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    vpc_endpoint_service_name: []const u8,

    pub const json_field_names = .{
        .vpc_endpoint_service_name = "VpcEndpointServiceName",
    };
};
