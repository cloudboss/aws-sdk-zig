const aws = @import("aws");

const Encryption = @import("encryption.zig").Encryption;
const EntitlementStatus = @import("entitlement_status.zig").EntitlementStatus;

/// The entitlements that you want to grant on a flow.
pub const GrantEntitlementRequest = struct {
    /// Percentage from 0-100 of the data transfer cost to be billed to the
    /// subscriber.
    data_transfer_subscriber_fee_percent: ?i32 = null,

    /// A description of the entitlement. This description appears only on the
    /// MediaConnect console and will not be seen by the subscriber or end user.
    description: ?[]const u8 = null,

    /// The type of encryption that will be used on the output that is associated
    /// with this entitlement. Allowable encryption types: static-key, speke.
    encryption: ?Encryption = null,

    /// An indication of whether the new entitlement should be enabled or disabled
    /// as soon as it is created. If you don’t specify the entitlementStatus field
    /// in your request, MediaConnect sets it to ENABLED.
    entitlement_status: ?EntitlementStatus = null,

    /// The key-value pairs that can be used to tag and organize the entitlement.
    entitlement_tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the entitlement. This value must be unique within the current
    /// flow.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account IDs that you want to share your content
    /// with. The receiving accounts (subscribers) will be allowed to create their
    /// own flows using your content as the source.
    subscribers: []const []const u8,

    pub const json_field_names = .{
        .data_transfer_subscriber_fee_percent = "DataTransferSubscriberFeePercent",
        .description = "Description",
        .encryption = "Encryption",
        .entitlement_status = "EntitlementStatus",
        .entitlement_tags = "EntitlementTags",
        .name = "Name",
        .subscribers = "Subscribers",
    };
};
