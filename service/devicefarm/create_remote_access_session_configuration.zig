const aws = @import("aws");

const BillingMethod = @import("billing_method.zig").BillingMethod;
const DeviceProxy = @import("device_proxy.zig").DeviceProxy;

/// Configuration settings for a remote access session, including billing
/// method.
pub const CreateRemoteAccessSessionConfiguration = struct {
    /// A list of upload ARNs for app packages to be installed onto your device.
    /// (Maximum 3)
    auxiliary_apps: ?[]const []const u8 = null,

    /// The billing method for the remote access session.
    billing_method: ?BillingMethod = null,

    /// The device proxy to be configured on the device for the remote access
    /// session.
    device_proxy: ?DeviceProxy = null,

    /// The name-value string pairs that specify additional settings for the remote
    /// access
    /// session.
    ///
    /// * `appium:version`: The major version of the Appium server to use for
    /// the session (for example, 2 or 3). The service may reject the selected
    /// version
    /// if it is not available for the selected device.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// An array of ARNs included in the VPC endpoint configuration.
    vpce_configuration_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .auxiliary_apps = "auxiliaryApps",
        .billing_method = "billingMethod",
        .device_proxy = "deviceProxy",
        .parameters = "parameters",
        .vpce_configuration_arns = "vpceConfigurationArns",
    };
};
