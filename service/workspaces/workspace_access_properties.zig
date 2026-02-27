const AccessEndpointConfig = @import("access_endpoint_config.zig").AccessEndpointConfig;
const AccessPropertyValue = @import("access_property_value.zig").AccessPropertyValue;

/// The device types and operating systems that can be used to access a
/// WorkSpace. For more
/// information, see [Amazon
/// WorkSpaces Client Network
/// Requirements](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-network-requirements.html).
pub const WorkspaceAccessProperties = struct {
    /// Specifies the configuration for accessing the WorkSpace.
    access_endpoint_config: ?AccessEndpointConfig,

    /// Indicates whether users can use Android and Android-compatible Chrome OS
    /// devices to
    /// access their WorkSpaces.
    device_type_android: ?AccessPropertyValue,

    /// Indicates whether users can use Chromebooks to access their WorkSpaces.
    device_type_chrome_os: ?AccessPropertyValue,

    /// Indicates whether users can use iOS devices to access their WorkSpaces.
    device_type_ios: ?AccessPropertyValue,

    /// Indicates whether users can use Linux clients to access their WorkSpaces.
    device_type_linux: ?AccessPropertyValue,

    /// Indicates whether users can use macOS clients to access their WorkSpaces.
    device_type_osx: ?AccessPropertyValue,

    /// Indicates whether users can access their WorkSpaces through a web browser.
    device_type_web: ?AccessPropertyValue,

    /// Indicates whether users can use Windows clients to access their WorkSpaces.
    device_type_windows: ?AccessPropertyValue,

    /// Indicates whether users can access their WorkSpaces through a WorkSpaces
    /// Thin Client.
    device_type_work_spaces_thin_client: ?AccessPropertyValue,

    /// Indicates whether users can use zero client devices to access their
    /// WorkSpaces.
    device_type_zero_client: ?AccessPropertyValue,

    pub const json_field_names = .{
        .access_endpoint_config = "AccessEndpointConfig",
        .device_type_android = "DeviceTypeAndroid",
        .device_type_chrome_os = "DeviceTypeChromeOs",
        .device_type_ios = "DeviceTypeIos",
        .device_type_linux = "DeviceTypeLinux",
        .device_type_osx = "DeviceTypeOsx",
        .device_type_web = "DeviceTypeWeb",
        .device_type_windows = "DeviceTypeWindows",
        .device_type_work_spaces_thin_client = "DeviceTypeWorkSpacesThinClient",
        .device_type_zero_client = "DeviceTypeZeroClient",
    };
};
