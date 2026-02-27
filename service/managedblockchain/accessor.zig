const aws = @import("aws");

const AccessorNetworkType = @import("accessor_network_type.zig").AccessorNetworkType;
const AccessorStatus = @import("accessor_status.zig").AccessorStatus;
const AccessorType = @import("accessor_type.zig").AccessorType;

/// The properties of the Accessor.
pub const Accessor = struct {
    /// The Amazon Resource Name (ARN) of the accessor. For more information about
    /// ARNs and their format, see [Amazon Resource
    /// Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The billing token is a property of the Accessor. Use this token to
    /// when making calls to the blockchain network. The billing token is used
    /// to track your accessor token for billing requests.
    billing_token: ?[]const u8,

    /// The creation date and time of the accessor.
    creation_date: ?i64,

    /// The unique identifier of the accessor.
    id: ?[]const u8,

    /// The blockchain network that the Accessor token is created for.
    network_type: ?AccessorNetworkType,

    /// The current status of the accessor.
    status: ?AccessorStatus,

    /// The tags assigned to the Accessor.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of the accessor.
    ///
    /// Currently, accessor type is restricted to `BILLING_TOKEN`.
    type: ?AccessorType,

    pub const json_field_names = .{
        .arn = "Arn",
        .billing_token = "BillingToken",
        .creation_date = "CreationDate",
        .id = "Id",
        .network_type = "NetworkType",
        .status = "Status",
        .tags = "Tags",
        .type = "Type",
    };
};
