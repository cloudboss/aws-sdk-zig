const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// The definition and status of the firewall endpoint for a single subnet. In
/// each configured subnet, Network Firewall instantiates a firewall
/// endpoint to handle network traffic.
///
/// This data type is used for any firewall endpoint type:
///
/// * For `Firewall.SubnetMappings`, this `Attachment` is part of the
///   `FirewallStatus` sync states information. You define firewall subnets
///   using `CreateFirewall` and `AssociateSubnets`.
///
/// * For `VpcEndpointAssociation`, this `Attachment` is part of the
///   `VpcEndpointAssociationStatus` sync states information. You define these
///   subnets using `CreateVpcEndpointAssociation`.
pub const Attachment = struct {
    /// The identifier of the firewall endpoint that Network Firewall has
    /// instantiated in the
    /// subnet. You use this to identify the firewall endpoint in the VPC route
    /// tables, when you
    /// redirect the VPC traffic through the endpoint.
    endpoint_id: ?[]const u8 = null,

    /// The current status of the firewall endpoint instantiation in the subnet.
    ///
    /// When this value is `READY`, the endpoint is available to handle network
    /// traffic. Otherwise,
    /// this value reflects its state, for example `CREATING` or `DELETING`.
    status: ?AttachmentStatus = null,

    /// If Network Firewall fails to create or delete the firewall endpoint in the
    /// subnet, it populates this with the reason for the error or failure and how
    /// to resolve it.
    /// A `FAILED` status indicates a non-recoverable state, and a `ERROR` status
    /// indicates an issue that you can fix.
    /// Depending on the error, it can take as many as 15 minutes to populate this
    /// field. For more information about the causes for failiure or errors and
    /// solutions available for this field, see [Troubleshooting firewall endpoint
    /// failures](https://docs.aws.amazon.com/network-firewall/latest/developerguide/firewall-troubleshooting-endpoint-failures.html) in the *Network Firewall Developer Guide*.
    status_message: ?[]const u8 = null,

    /// The unique identifier of the subnet that you've specified to be used for a
    /// firewall endpoint.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .status = "Status",
        .status_message = "StatusMessage",
        .subnet_id = "SubnetId",
    };
};
