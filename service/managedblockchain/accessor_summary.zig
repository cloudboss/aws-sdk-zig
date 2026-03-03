const AccessorNetworkType = @import("accessor_network_type.zig").AccessorNetworkType;
const AccessorStatus = @import("accessor_status.zig").AccessorStatus;
const AccessorType = @import("accessor_type.zig").AccessorType;

/// A summary of accessor properties.
pub const AccessorSummary = struct {
    /// The Amazon Resource Name (ARN) of the accessor. For more information about
    /// ARNs and their format, see [Amazon Resource
    /// Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The creation date and time of the accessor.
    creation_date: ?i64 = null,

    /// The unique identifier of the accessor.
    id: ?[]const u8 = null,

    /// The blockchain network that the Accessor token is created for.
    network_type: ?AccessorNetworkType = null,

    /// The current status of the accessor.
    status: ?AccessorStatus = null,

    /// The type of the accessor.
    ///
    /// Currently accessor type is restricted to `BILLING_TOKEN`.
    @"type": ?AccessorType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .id = "Id",
        .network_type = "NetworkType",
        .status = "Status",
        .@"type" = "Type",
    };
};
