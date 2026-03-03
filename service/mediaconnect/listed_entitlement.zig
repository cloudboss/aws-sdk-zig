/// An entitlement that has been granted to you from other Amazon Web Services
/// accounts.
pub const ListedEntitlement = struct {
    /// Percentage from 0-100 of the data transfer cost to be billed to the
    /// subscriber.
    data_transfer_subscriber_fee_percent: ?i32 = null,

    /// The ARN of the entitlement.
    entitlement_arn: []const u8,

    /// The name of the entitlement.
    entitlement_name: []const u8,

    pub const json_field_names = .{
        .data_transfer_subscriber_fee_percent = "DataTransferSubscriberFeePercent",
        .entitlement_arn = "EntitlementArn",
        .entitlement_name = "EntitlementName",
    };
};
