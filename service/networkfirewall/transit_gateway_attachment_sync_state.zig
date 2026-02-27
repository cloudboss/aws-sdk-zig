const TransitGatewayAttachmentStatus = @import("transit_gateway_attachment_status.zig").TransitGatewayAttachmentStatus;

/// Contains information about the synchronization state of a transit gateway
/// attachment, including its current status and any error messages. Network
/// Firewall uses this to track the state of your transit gateway configuration
/// changes.
pub const TransitGatewayAttachmentSyncState = struct {
    /// The unique identifier of the transit gateway attachment.
    attachment_id: ?[]const u8,

    /// A message providing additional information about the current status,
    /// particularly useful when the transit gateway attachment is in a non-`READY`
    /// state.
    ///
    /// Valid values are:
    ///
    /// * `CREATING` - The attachment is being created
    ///
    /// * `DELETING` - The attachment is being deleted
    ///
    /// * `DELETED` - The attachment has been deleted
    ///
    /// * `FAILED` - The attachment creation has failed and cannot be recovered
    ///
    /// * `ERROR` - The attachment is in an error state that might be recoverable
    ///
    /// * `READY` - The attachment is active and processing traffic
    ///
    /// * `PENDING_ACCEPTANCE` - The attachment is waiting to be accepted
    ///
    /// * `REJECTING` - The attachment is in the process of being rejected
    ///
    /// * `REJECTED` - The attachment has been rejected
    ///
    /// For information about troubleshooting endpoint failures, see
    /// [Troubleshooting firewall endpoint
    /// failures](https://docs.aws.amazon.com/network-firewall/latest/developerguide/firewall-troubleshooting-endpoint-failures.html) in the *Network Firewall Developer Guide*.
    status_message: ?[]const u8,

    /// The current status of the transit gateway attachment.
    ///
    /// Valid values are:
    ///
    /// * `CREATING` - The attachment is being created
    ///
    /// * `DELETING` - The attachment is being deleted
    ///
    /// * `DELETED` - The attachment has been deleted
    ///
    /// * `FAILED` - The attachment creation has failed and cannot be recovered
    ///
    /// * `ERROR` - The attachment is in an error state that might be recoverable
    ///
    /// * `READY` - The attachment is active and processing traffic
    ///
    /// * `PENDING_ACCEPTANCE` - The attachment is waiting to be accepted
    ///
    /// * `REJECTING` - The attachment is in the process of being rejected
    ///
    /// * `REJECTED` - The attachment has been rejected
    transit_gateway_attachment_status: ?TransitGatewayAttachmentStatus,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .status_message = "StatusMessage",
        .transit_gateway_attachment_status = "TransitGatewayAttachmentStatus",
    };
};
