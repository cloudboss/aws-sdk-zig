const BillingMethod = @import("billing_method.zig").BillingMethod;
const DeviceProxy = @import("device_proxy.zig").DeviceProxy;

/// Configuration settings for a remote access session, including billing
/// method.
pub const CreateRemoteAccessSessionConfiguration = struct {
    /// A list of upload ARNs for app packages to be installed onto your device.
    /// (Maximum 3)
    auxiliary_apps: ?[]const []const u8,

    /// The billing method for the remote access session.
    billing_method: ?BillingMethod,

    /// The device proxy to be configured on the device for the remote access
    /// session.
    device_proxy: ?DeviceProxy,

    /// An array of ARNs included in the VPC endpoint configuration.
    vpce_configuration_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .auxiliary_apps = "auxiliaryApps",
        .billing_method = "billingMethod",
        .device_proxy = "deviceProxy",
        .vpce_configuration_arns = "vpceConfigurationArns",
    };
};
