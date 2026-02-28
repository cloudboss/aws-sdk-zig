const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;

/// An object representing a container instance or task attachment.
pub const Attachment = struct {
    /// Details of the attachment.
    ///
    /// For elastic network interfaces, this includes the network interface ID, the
    /// MAC
    /// address, the subnet ID, and the private IPv4 address.
    ///
    /// For Service Connect services, this includes `portName`,
    /// `clientAliases`, `discoveryName`, and
    /// `ingressPortOverride`.
    ///
    /// For Elastic Block Storage, this includes `roleArn`,
    /// `deleteOnTermination`, `volumeName`, `volumeId`,
    /// and `statusReason` (only when the attachment fails to create or
    /// attach).
    details: ?[]const KeyValuePair,

    /// The unique identifier for the attachment.
    id: ?[]const u8,

    /// The status of the attachment. Valid values are `PRECREATED`,
    /// `CREATED`, `ATTACHING`, `ATTACHED`,
    /// `DETACHING`, `DETACHED`, `DELETED`, and
    /// `FAILED`.
    status: ?[]const u8,

    /// The type of the attachment, such as `ElasticNetworkInterface`,
    /// `Service Connect`, and `AmazonElasticBlockStorage`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .details = "details",
        .id = "id",
        .status = "status",
        .@"type" = "type",
    };
};
