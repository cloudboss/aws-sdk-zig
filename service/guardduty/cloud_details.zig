const CloudProvider = @import("cloud_provider.zig").CloudProvider;

/// Contains details about the cloud environment associated with an
/// investigation.
pub const CloudDetails = struct {
    /// The Amazon Web Services account ID of the investigated resource.
    account: []const u8,

    /// The cloud provider. Currently, only `AWS` is supported.
    provider: CloudProvider,

    /// The Amazon Web Services Region in which the investigated resource resides.
    region: []const u8,

    pub const json_field_names = .{
        .account = "Account",
        .provider = "Provider",
        .region = "Region",
    };
};
