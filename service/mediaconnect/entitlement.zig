const Encryption = @import("encryption.zig").Encryption;
const EntitlementStatus = @import("entitlement_status.zig").EntitlementStatus;

/// The settings for a flow entitlement.
pub const Entitlement = struct {
    /// Percentage from 0-100 of the data transfer cost to be billed to the
    /// subscriber.
    data_transfer_subscriber_fee_percent: ?i32 = null,

    /// A description of the entitlement.
    description: ?[]const u8 = null,

    /// The type of encryption that will be used on the output that is associated
    /// with this entitlement.
    encryption: ?Encryption = null,

    /// The ARN of the entitlement.
    entitlement_arn: []const u8,

    /// An indication of whether the entitlement is enabled.
    entitlement_status: ?EntitlementStatus = null,

    /// The name of the entitlement.
    name: []const u8,

    /// The Amazon Web Services account IDs that you want to share your content
    /// with. The receiving accounts (subscribers) will be allowed to create their
    /// own flow using your content as the source.
    subscribers: []const []const u8,

    pub const json_field_names = .{
        .data_transfer_subscriber_fee_percent = "DataTransferSubscriberFeePercent",
        .description = "Description",
        .encryption = "Encryption",
        .entitlement_arn = "EntitlementArn",
        .entitlement_status = "EntitlementStatus",
        .name = "Name",
        .subscribers = "Subscribers",
    };
};
