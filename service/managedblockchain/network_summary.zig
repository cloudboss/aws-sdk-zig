const Framework = @import("framework.zig").Framework;
const NetworkStatus = @import("network_status.zig").NetworkStatus;

/// A summary of network configuration properties.
pub const NetworkSummary = struct {
    /// The Amazon Resource Name (ARN) of the network. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The date and time that the network was created.
    creation_date: ?i64 = null,

    /// An optional description of the network.
    description: ?[]const u8 = null,

    /// The blockchain framework that the network uses.
    framework: ?Framework = null,

    /// The version of the blockchain framework that the network uses.
    framework_version: ?[]const u8 = null,

    /// The unique identifier of the network.
    id: ?[]const u8 = null,

    /// The name of the network.
    name: ?[]const u8 = null,

    /// The current status of the network.
    status: ?NetworkStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .framework = "Framework",
        .framework_version = "FrameworkVersion",
        .id = "Id",
        .name = "Name",
        .status = "Status",
    };
};
