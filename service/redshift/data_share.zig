const DataShareAssociation = @import("data_share_association.zig").DataShareAssociation;
const DataShareType = @import("data_share_type.zig").DataShareType;

pub const DataShare = struct {
    /// A value that specifies whether the datashare can be shared to a publicly
    /// accessible cluster.
    allow_publicly_accessible_consumers: ?bool,

    /// The Amazon Resource Name (ARN) of the datashare that the consumer is to use.
    data_share_arn: ?[]const u8,

    /// A value that specifies when the datashare has an association between
    /// producer and data
    /// consumers.
    data_share_associations: ?[]const DataShareAssociation,

    /// The type of the datashare created by RegisterNamespace.
    data_share_type: ?DataShareType,

    /// The identifier of a datashare to show its managing entity.
    managed_by: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the producer namespace.
    producer_arn: ?[]const u8,
};
